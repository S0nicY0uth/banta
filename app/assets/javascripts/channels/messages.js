function message_subscription(room){
  AppCable.messages = AppCable.cable.subscriptions.create({channel: "MessagesChannel", room: room}, {
    connected: function() {
      console.log('connected');
    },
  
    disconnected: function() {
      console.log('disconnected');
    },
  
    received: function(data) {
      console.log('received', data);
      $('.convo').append(data.message);
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

      