package game.view.hero
{
   import game.battle.controller.position.HeroViewPositionValue;
   import game.data.storage.DataStorage;
   import starling.core.Starling;
   
   public class FreeTowerHero extends FreeHero
   {
       
      
      private var _index:int = 0;
      
      public function FreeTowerHero()
      {
         super();
      }
      
      override protected function getScale() : Number
      {
         return 1;
      }
      
      override public function setPosition(param1:Number, param2:Number) : void
      {
         var _loc3_:* = param1;
         target.x = _loc3_;
         position.x = _loc3_;
         _loc3_ = param2;
         target.y = _loc3_;
         position.y = _loc3_;
      }
      
      public function setTeamPositionIndex(param1:int) : void
      {
         _index = param1;
      }
      
      override public function advanceTime(param1:Number) : void
      {
         move(param1);
         if(view.position.movement == 0 && view.canStrafe)
         {
            if(Math.random() < 0.002)
            {
               view.win();
            }
         }
         view.position.scale = 0.85 / (1 - position.y * 0.00075);
         view.position.isMoveable = true;
         view.updatePosition();
      }
      
      override protected function move(param1:Number) : void
      {
         var _loc4_:Number = NaN;
         _loc4_ = 155;
         var _loc10_:* = NaN;
         _loc10_ = 60;
         var _loc8_:HeroViewPositionValue = view.position;
         var _loc2_:Number = _index % 2 * 15 + 5;
         var _loc9_:* = 1;
         if(view.position.x < 155)
         {
            _loc9_ = Number(view.position.x / 155);
            _loc2_ = _loc2_ * (_loc9_ * _loc9_);
            if(target.x < view.position.x)
            {
               _loc2_ = _loc2_ + (_loc9_ - 1) * 60;
            }
         }
         else if(view.position.x > Starling.current.stage.stageWidth - 155)
         {
            _loc9_ = Number(1 - (view.position.x - Starling.current.stage.stageWidth + 155) / 155);
            _loc2_ = _loc2_ * (_loc9_ * _loc9_);
            if(target.x > view.position.x)
            {
               _loc2_ = _loc2_ + (_loc9_ - 1) * 60;
            }
         }
         _loc8_.direction = target.x > position.x?1:target.x < position.x?-1:_loc8_.direction;
         var _loc7_:Number = DataStorage.battleConfig.core.defaultHeroSpeed * param1;
         var _loc3_:Number = target.x - position.x;
         var _loc6_:Number = target.y - position.y;
         var _loc5_:Number = Math.sqrt(_loc3_ * _loc3_ + _loc6_ * _loc6_);
         if(_loc7_ > _loc5_)
         {
            position.x = target.x;
            position.y = target.y;
            _loc8_.movement = 0;
         }
         else
         {
            position.x = position.x + _loc7_ * _loc3_ / _loc5_;
            position.y = position.y + _loc7_ * _loc6_ / _loc5_;
            _loc8_.movement = _loc3_ * _loc3_ > _loc6_ * _loc6_?1:2;
         }
         _loc8_.x = position.x;
         _loc8_.y = position.y + _loc2_;
         _loc8_.z = _loc8_.y;
         view.updatePosition();
      }
   }
}
