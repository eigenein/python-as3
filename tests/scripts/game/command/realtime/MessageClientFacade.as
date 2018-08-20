package game.command.realtime
{
   import game.model.user.Player;
   
   public class MessageClientFacade
   {
       
      
      private var player:Player;
      
      private var pushdClient:MessageClientBase;
      
      public function MessageClientFacade()
      {
         super();
      }
      
      public function create(param1:Boolean) : void
      {
         if(!param1)
         {
            pushdClient = new PushdClient();
         }
      }
      
      public function initialize(param1:Player, param2:Object) : void
      {
         pushdClient.initialize(param1.id,param2);
      }
      
      public function subscribe(param1:String, param2:Function) : void
      {
         pushdClient.subscribe(param1,param2);
      }
      
      public function unsubscribe(param1:String, param2:Function) : void
      {
         pushdClient.unsubscribe(param1,param2);
      }
   }
}
