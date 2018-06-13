// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
class App {
	constructor(options, ready){
		this.nav = options.nav;
		this.msgContainer = options.msgContainer;
		this.user = options.user_id;
		this.message_area = options.message_area;
		this.ready = ready
		this.init();
	}

	init(){
		this.roomList = new RoomList(() => {
			//get current room
			this.current_room_id = this.roomList.getCurrentRoom();
			//initialize the connection to ActionCable
			this.ActionCableHandler = new ActionCableHandler(this.user);
			//initial rendering
			this.roomList.render(this.nav);
			this.createLogout(this.nav);
			
			if (this.current_room_id){
				this.setActiveLink(document.getElementById(this.current_room_id).parentNode);
				this.renderSearchBar(this.message_area, this.current_room_id);
				//set the currentRoom
				this.setRoom(this.roomList.list, this.current_room_id);
				//get the inital messages
				this.messages = new Messages(this.current_room_id, ()=>{
					console.log(this, 'this in messages');
					document.querySelector(this.msgContainer).innerHTML = '';
					this.messages.render(this.msgContainer,this.user);
					scroll('.convo');
				});
			}
			
			this.roomList.list.forEach(function(room){
				document.getElementById(room.id).addEventListener('click',function(e){
					document.querySelectorAll(".nav ul li").forEach(function(li){
						this.removeActiveLink(li);
					}.bind(this));
					this.setActiveLink(e.target.parentNode);
					this.setRoom(this.roomList.list, e.target.getAttribute('index'));
					this.renderSearchBar(this.message_area,this.currentRoom.id);
					this.searchHandler(this.message_area,this.currentRoom.id);
					this.actionCableInit(this.currentRoom.id);
					this.messages = new Messages(e.target.id, ()=>{
						document.querySelector(this.msgContainer).innerHTML = '';
						this.messages.render(this.msgContainer,this.user);
						scroll('.convo');
					});
				}.bind(this));
			}.bind(this));
			this.ready && this.ready();
		})
	}

	onceLinkClicked(cb){

	}

	removeActiveLink(li){
		if(li.classList.contains('active')){
			document.querySelector('.active').classList.remove("active");
		}
	}

	setActiveLink(a){
		a.classList.add("active");
	}

	actionCableInit(id){
		this.ActionCableHandler.restart(id);
	}

	createLogout(nav){
		let div = document.createElement('div');
		let a = document.createElement('a');
		a.href = "/users/sign_out";
		a.innerHTML = "Logout";
		a.setAttribute('rel', 'nofollow');
		a.setAttribute('data-method', 'delete');
		div.classList.add('destroy');
		div.appendChild(a);
		document.querySelector(nav).appendChild(div);
	}

	sendWithEnter(){
		$(".message textarea").keypress(function(event) {
			if (event.which == 13) {
				event.preventDefault();         
				Rails.fire(document.querySelector(".nifty_form"), 'submit');
			  }
		  });
	}

	renderSearchBar(el, current_room){
		let target = document.querySelector(el);
		target.innerHTML = '';
		let form = document.createElement('form');
		let submit = document.createElement('input');
		let textarea = document.createElement('textarea');

		submit.setAttribute('type','submit');
		submit.setAttribute('value','Godspeed!');
		submit.className = "submit-btn";

		textarea.id = "content";
		textarea.name = "content";
		form.append(textarea);

		form.className = 'nifty_form';
		form.method = 'POST';
		form.setAttribute('action','/chat_rooms/'+ current_room +'/messages');
		form.append(submit);


		target.append(form);

		this.sendWithEnter();
	}

	searchHandler(el,current_room){
		let form = document.querySelector(el + ' form');

		form.addEventListener('submit',function(e){
			e.preventDefault();
			let data = {content: document.getElementById('content').value}
			var xhr = new XMLHttpRequest();
			let token = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
			xhr.open('POST', '/chat_rooms/'+ current_room +'/messages.json');
			xhr.setRequestHeader('Content-Type', 'application/json');
			xhr.setRequestHeader('X-CSRF-Token', token);
			xhr.onload = function() {
				if (xhr.status === 200) {
					var userInfo = JSON.parse(xhr.responseText);
				}
			};
			xhr.send(JSON.stringify(data));

		});
	}

	setRoom(roomList, index){
		this.currentRoom = roomList[index];
	}

}

class RoomList {
	constructor(cb){
		this.getRooms(cb);
	}

	setRoomList(roomList){
		this.list = roomList;
	}

	getCurrentRoom(){
		let name = window.location.hash;
		let id;
		for(let i = 0; i < this.list.length; i++){
			console.log('#'+this.list[i].name == name);
			if('#'+this.list[i].name == name){
				id = this.list[i].id;
			}
		};
		if (id > 0){
			return id;
		} else {
			return false;
		}
	}

	getRooms(cb){
		fetch('/chat_rooms.json')
		.then(function(response) {
			return response.json();
		})
		.then(function(json) {
			console.log(json, 'this is the returned json data');
			this.setRoomList(json);
			cb(json);
		}.bind(this))
		.catch(function(err) {
			console.log('Fetch Error :-S', err);
		});
	}

	render(el){
		var target = document.querySelector(el + ' ul');
		for(let i =0; i < this.list.length; i ++){
			var li = document.createElement('li');
			var a = document.createElement('a');
			a.textContent = this.list[i].name;
			a.id = this.list[i].id;
			a.setAttribute('index', i);
			a.setAttribute('href', '#'+this.list[i].name);

			li.appendChild(a);
			target.appendChild(li);
		}
	}


}

class Messages {
	constructor(room_id, cb){
		this.current_room_id = room_id;
		this.getMessages(cb);
	}
	getMessages(cb){
		fetch('/chat_rooms/'+ this.current_room_id +'/messages.json')
		.then(function(response) {
			return response.json();
		})
		.then(function(json) {
			this.refreshMessageList(json)
			cb();
		}.bind(this))
		.catch(function(err) {
			console.log('Fetch Error :-S', err);
		});
	}

	refreshMessageList(data){
		this.messageList = data
	}

	render(el, user){
		let target = document.querySelector(el);
		this.messageList.forEach(function(msg){
			let bubble = document.createElement('div');
			let userSpan = document.createElement('span');
			let timeSpan = document.createElement('span');

			console.log(msg.user_id == this.current_user)
			
			this.bubbleDirection(bubble,msg.user_id, user);

			bubble.setAttribute('sent-time', msg.created_at);
			bubble.textContent = msg.content;

			userSpan.className = "username";
			timeSpan.className = "time";

			userSpan.textContent = msg.user_name;
			timeSpan.textContent = moment(msg.created_at).format('ddd HH:mm');
			

			bubble.prepend(userSpan);
			bubble.prepend(timeSpan);
			target.append(bubble);

		}.bind(this));
	}

	bubbleDirection(div,msg_u_id, current_user_id){
		//determines whether the message being rendered was sent by the current user. 
		if (msg_u_id == current_user_id){
				div.className = "bubble current";
			} else {
				div.className = "bubble";
			}
		return div;
	}


}

class ActionCableHandler{

	constructor(user){
		this.user_id = user;
		console.log(this.user_id);
	}

	restart(room){
		if (AppCable.messages){
			AppCable.messages.unsubscribe();
		}
		this.subscribe(room);
	}

	
	subscribe(room){
		AppCable.messages = AppCable.cable.subscriptions.create({channel: "MessagesChannel", room: room}, {
			connected: function() {
				console.log('connected');
			},
		
			disconnected: function() {
				console.log('disconnected');
			},
		
			received: function(data) {
				let msg = JSON.parse(data.message);
				console.log('msg: user_id...', msg.user_id, 'this.user_id...', this.user_id);
				if (msg.user_id == this.user_id){
					let div = "<div class='bubble current transition'><span class='time'>"+moment(msg.created_at).format('ddd HH:mm')+"</span><span class='username'>"+msg.user+"</span>"+msg.content+"</div>";
					$('.convo').append(div);
				} else {
					console.log('else', msg.content);
					let div = "<div class='bubble'><span class='time'>"+moment(msg.created_at).format('ddd HH:mm')+"</span><span class='username'>"+msg.user+"</span>"+msg.content+"</div>";
					$('.convo').append(div);
				}

				scroll('.convo');

				document.querySelector(".message textarea").value = "";   
				setTimeout(function(){
					$('.transition').removeClass('transition');    
				},200);
			}.bind(this)
  		});
	}
	
}

function scroll(div){
	  var objDiv = document.querySelector(div);
	  objDiv.scrollTop = objDiv.scrollHeight;
	}