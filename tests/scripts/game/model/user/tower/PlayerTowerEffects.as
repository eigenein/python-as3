package game.model.user.tower
{
   import flash.utils.Dictionary;
   import idv.cjcat.signals.Signal;
   
   public class PlayerTowerEffects
   {
       
      
      private var dict:Dictionary;
      
      private var _signal_update:Signal;
      
      public function PlayerTowerEffects()
      {
         dict = new Dictionary();
         _signal_update = new Signal();
         super();
      }
      
      public function get signal_update() : Signal
      {
         return _signal_update;
      }
      
      public function parse(param1:Object) : void
      {
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = param1;
         for(var _loc3_ in param1)
         {
            _loc2_ = dict[_loc3_];
            if(!_loc2_)
            {
               var _loc4_:* = new PlayerTowerBuffEffect();
               dict[_loc3_] = _loc4_;
               _loc2_ = _loc4_;
            }
            _loc2_.setup(_loc3_,param1[_loc3_]);
         }
         _signal_update.dispatch();
      }
      
      public function clear() : void
      {
         dict = new Dictionary();
      }
      
      public function getList() : Vector.<PlayerTowerBuffEffect>
      {
         var _loc2_:Vector.<PlayerTowerBuffEffect> = new Vector.<PlayerTowerBuffEffect>();
         var _loc4_:int = 0;
         var _loc3_:* = dict;
         for each(var _loc1_ in dict)
         {
            _loc2_.push(_loc1_);
         }
         _loc2_.sort(PlayerTowerBuffEffect.sort_goldFirst);
         return _loc2_;
      }
   }
}
