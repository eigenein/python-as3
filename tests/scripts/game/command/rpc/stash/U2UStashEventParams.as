package game.command.rpc.stash
{
   import engine.context.platform.social.U2URequestSendResult;
   
   public class U2UStashEventParams extends StashEventParams
   {
       
      
      private var r:U2URequestSendResult;
      
      private var type:String;
      
      public function U2UStashEventParams(param1:U2URequestSendResult, param2:String)
      {
         super();
         this.type = param2;
         this.r = param1;
      }
      
      override public function serialize() : Object
      {
         var _loc4_:int = 0;
         var _loc3_:Array = [];
         var _loc1_:int = r.uids.length;
         _loc4_ = 0;
         while(_loc4_ < _loc1_)
         {
            _loc3_.push(r.uids[_loc4_]);
            _loc4_++;
         }
         var _loc2_:Object = {
            "ids":_loc3_,
            "type":type
         };
         return _loc2_;
      }
   }
}
