package game.command.rpc.clan.value
{
   import flash.utils.Dictionary;
   import idv.cjcat.signals.Signal;
   
   public class ClanBlackListValueObject
   {
       
      
      private var _list:Dictionary;
      
      private var _signal_blackListUpdate:Signal;
      
      public function ClanBlackListValueObject(param1:Object)
      {
         super();
         _list = new Dictionary();
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            _list[_loc2_] = param1[_loc2_];
         }
         _signal_blackListUpdate = new Signal();
      }
      
      public function get list() : Dictionary
      {
         return _list;
      }
      
      public function get signal_blackListUpdate() : Signal
      {
         return _signal_blackListUpdate;
      }
   }
}
