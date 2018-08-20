package game.model.user.shop
{
   import engine.core.utils.VectorUtil;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import game.command.timer.GameTimer;
   import idv.cjcat.signals.ISignal;
   import idv.cjcat.signals.Signal;
   
   public class SpecialShopMerchant
   {
       
      
      private var _id:int;
      
      private var _heroes:Vector.<SpecialShopHeroValueObject>;
      
      private var _signal_dismiss:Signal;
      
      private var _signal_expire:Signal;
      
      private var _availableUntil:int;
      
      private var _timeoutId:uint;
      
      private var _available:Boolean = true;
      
      public function SpecialShopMerchant(param1:Object)
      {
         var _loc3_:int = 0;
         _signal_dismiss = new Signal(SpecialShopMerchant);
         _signal_expire = new Signal(SpecialShopMerchant);
         super();
         _availableUntil = param1.availableUntil;
         if(timeLeft > 0)
         {
            _timeoutId = setTimeout(onEnd,timeLeft * 1000);
         }
         _heroes = new Vector.<SpecialShopHeroValueObject>();
         var _loc2_:Array = param1.heroes;
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _heroes.push(new SpecialShopHeroValueObject(_loc2_[_loc3_]));
            _loc3_++;
         }
      }
      
      private function onEnd() : void
      {
         clearTimeout(_timeoutId);
         if(timeLeft > 0)
         {
            _timeoutId = setTimeout(onEnd,timeLeft * 1000);
         }
         else
         {
            _signal_expire.dispatch(this);
            dismiss();
         }
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function get heroes() : Vector.<SpecialShopHeroValueObject>
      {
         return _heroes;
      }
      
      public function get timeLeft() : Number
      {
         var _loc1_:Number = _availableUntil - GameTimer.instance.currentServerTime;
         return _loc1_ > 0?_loc1_:0;
      }
      
      public function canBuy() : Boolean
      {
         return _available && _heroes.length > 0;
      }
      
      public function get signal_dismiss() : ISignal
      {
         return _signal_dismiss;
      }
      
      public function dismiss() : void
      {
         clearTimeout(_timeoutId);
         _available = false;
         _signal_dismiss.dispatch(this);
      }
      
      public function get signal_expire() : ISignal
      {
         return _signal_expire;
      }
      
      public function updateHero(param1:Object) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         if(param1)
         {
            _loc2_ = 0;
            while(_loc2_ < _heroes.length)
            {
               if(_heroes[_loc2_].heroId == param1.heroId)
               {
                  VectorUtil.removeAt(_heroes,_loc2_);
                  break;
               }
               _loc2_++;
            }
            _loc3_ = new SpecialShopHeroValueObject(param1);
            if(_loc3_.hasSlots)
            {
               _heroes.push(_loc3_);
            }
         }
      }
   }
}
