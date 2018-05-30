describe("Some basic App", function() {
  var app;
  var fetch = sinon.stub(window, 'fetch');
  var nav = '.nav';
  var realWS = WebSocket;

  beforeEach(function(done) {
    

    createResponse = function(json){
      return new window.Response(JSON.stringify(json),
      {
        status: 200,
        headers: {
          'Content-type': 'application/json'
        }
      });
    }

    // var WebSocketSpy = spyOn(window, "WebSocket").and.callFake(function(url,protocols){
    //   return new realWS(url,protocols);
    // });

    roomsJson = [
      {"id":1,"name":"Sport","created_at":"2018-05-07T19:35:06.397Z","updated_at":"2018-05-07T19:35:06.397Z"},
      {"id":2,"name":"Politics","created_at":"2018-05-07T19:35:06.401Z","updated_at":"2018-05-07T19:35:06.401Z"}
    ]

    var messagesJson = [
      {"id":1,"content":"foo","created_at":"2018-05-07T19:35:06.764Z","updated_at":"2018-05-07T19:35:06.764Z","user_name":"Chris Hopkins","user_id":1},
      {"id":6,"content":"hi","created_at":"2018-05-07T19:35:06.786Z","updated_at":"2018-05-07T19:35:06.786Z","user_name":"Dan Stein","user_id":3},
      {"id":9,"content":"array","created_at":"2018-05-07T19:35:06.800Z","updated_at":"2018-05-07T19:35:06.800Z","user_name":"Ben Pirt","user_id":5},
      {"id":17,"content":"hahha","created_at":"2018-05-08T09:59:22.444Z","updated_at":"2018-05-08T09:59:22.444Z","user_name":"Chris Hopkins","user_id":1}
    ]

    fetch.withArgs('/chat_rooms.json').returns(Promise.resolve(createResponse(roomsJson)));
    fetch.withArgs('/chat_rooms/1/messages.json').returns(Promise.resolve(createResponse(messagesJson)));
    console.log("Before Each Called")
    $('<div class="grid-container"><div class="nav"><div class="logo"><h1>Banta<span class="head-stop">.</span></h1></div><h5>Channels</h5><ul></ul></div><div class="convo"></div><div class="message"></div></div>').appendTo('body');
    // loadFixtures('jsui_fixture.html');
    app = new App({nav: nav, msgContainer:'.convo',message_area: '.message', user_id: 1}, () => done());
  });

  afterEach(function(){
    //window.fetch.restore();
    $('.grid-container').remove()
    delete app;
  });

  it("should know the nave of it's nav", function() {
    expect(app.nav).toBe('.nav');
  });

  it("should know the id of it's user", function() {
    expect(app.user).toBe(1);
  });

  it("should know where to append the messages", function() {
    expect(app.msgContainer).toBe('.convo');
  });

  it("should know where to draw the form", function() {
    expect(app.message_area).toBe('.message');
  });

  it("should have a list of rooms", function() {
    expect(app.roomList.list.length).toBe(2);
    expect(app.roomList.list[0].name).toBe('Sport');
    expect(app.roomList.list[1].name).toBe('Politics');
  });

  it("when I click on a room, it should show me the messages of that room", function(done){
    setTimeout(function(){
      $('.nav li a#1')[0].click();
        let statement = $('.bubble').html().indexOf('foo')!== -1;
        expect(statement).toBe(true);
        done();
    },400);
  });


});