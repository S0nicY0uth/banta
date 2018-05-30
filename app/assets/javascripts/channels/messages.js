function message_subscription(room){
  AppCable.messages = AppCable.cable.subscriptions.create({channel: "MessagesChannel", room: room}, {
    connected: function() {
      console.log('connected');
    },
  
    disconnected: function() {
      console.log('disconnected');
    },
  
    received: function(data) {
      let msg = JSON.parse(data.message);
      console.log(data);
      let bubble = document.createElement('div');
			let userSpan = document.createElement('span');
			let timeSpan = document.createElement('span');

      bubble.setAttribute('sent-time', msg.created_at);
			bubble.textContent = msg.content;

			userSpan.className = "username";
      timeSpan.className = "time";
      bubble.className = "bubble transition";

			userSpan.textContent = msg.user;
			timeSpan.textContent = moment(msg.created_at).format('ddd HH:mm');
			

			bubble.prepend(userSpan);
			bubble.prepend(timeSpan);
			
      $('.convo').append(bubble);

      document.querySelector(".message textarea").value = "";   
      setTimeout(function(){
        $('.transition').removeClass('transition'); 
        scroll('.convo');    
      },200);
    }
  });
}

function scroll(div){
    var objDiv = document.querySelector(div);
    objDiv.scrollTop = objDiv.scrollHeight;
    
  }

      