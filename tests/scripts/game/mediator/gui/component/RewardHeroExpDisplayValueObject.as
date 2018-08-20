package game.mediator.gui.component
{
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.level.HeroLevel;
   import game.mediator.gui.popup.hero.PlayerHeroEntryValueObject;
   import game.model.user.hero.PlayerHeroEntry;
   import idv.cjcat.signals.Signal;
   import starling.animation.Tween;
   import starling.core.Starling;
   
   public class RewardHeroExpDisplayValueObject extends PlayerHeroEntryValueObject
   {
       
      
      private var _startExp:int;
      
      private var _targetExp:int;
      
      private var _signal_levelUp:Signal;
      
      private var _signal_xpUpdate:Signal;
      
      private var _currentXPPercent:Number;
      
      private var _currentExp:int;
      
      public function RewardHeroExpDisplayValueObject(param1:HeroDescription, param2:PlayerHeroEntry, param3:int)
      {
         _signal_levelUp = new Signal();
         _signal_xpUpdate = new Signal();
         super(param1,param2);
         _currentExp = Math.max(param2.experience - param3,0);
         _startExp = _currentExp;
         _targetExp = param2.experience;
      }
      
      public function get signal_levelUp() : Signal
      {
         return _signal_levelUp;
      }
      
      public function get signal_xpUpdate() : Signal
      {
         return _signal_xpUpdate;
      }
      
      public function get currentXPPercent() : Number
      {
         var _loc1_:HeroLevel = DataStorage.level.getHeroLevelByExp(_currentExp);
         var _loc2_:int = _loc1_.exp;
         var _loc3_:int = !!_loc1_.nextLevel?_loc1_.nextLevel.exp:int(_loc2_);
         if(_loc2_ != _loc3_)
         {
            return (_currentExp - _loc2_) / (_loc3_ - _loc2_);
         }
         return 1;
      }
      
      public function get rewardExp() : int
      {
         return _currentExp - _startExp;
      }
      
      public function get currentExp() : int
      {
         return _currentExp;
      }
      
      public function set currentExp(param1:int) : void
      {
         var _loc2_:int = level;
         _currentExp = param1;
         if(level != _loc2_)
         {
            _signal_levelUp.dispatch();
         }
      }
      
      override public function get level() : int
      {
         return DataStorage.level.getHeroLevelByExp(_currentExp).level;
      }
      
      public function startXPTween() : void
      {
         var _loc1_:Tween = new Tween(this,0.6);
         _loc1_.animate("currentExp",_targetExp);
         _loc1_.onUpdate = handler_tweenUpdate;
         Starling.juggler.add(_loc1_);
      }
      
      private function handler_tweenUpdate() : void
      {
         _signal_xpUpdate.dispatch();
      }
   }
}
