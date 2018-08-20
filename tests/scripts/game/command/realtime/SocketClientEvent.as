package game.command.realtime
{
   public class SocketClientEvent
   {
       
      
      private var _data:Object;
      
      public function SocketClientEvent(param1:Object)
      {
         super();
         this._data = param1;
      }
      
      public function get data() : Object
      {
         return _data;
      }
      
      public function get type() : String
      {
         return !!data?data.type:null;
      }
      
      public function get pushUserId() : String
      {
         return data.body.pushUserId;
      }
   }
}
