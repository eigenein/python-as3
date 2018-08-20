package game.view.hero
{
   import flash.geom.Point;
   import game.assets.IHeroAsset;
   import game.assets.storage.RsxGameAsset;
   import game.battle.view.hero.HeroView;
   import game.data.storage.DataStorage;
   import idv.cjcat.signals.Signal;
   
   public class FreeHero
   {
       
      
      public const position:Point = new Point();
      
      public const view:HeroView = new HeroView();
      
      protected var target:Point;
      
      protected var _speed:Number;
      
      protected var movement:int;
      
      private var asset:IHeroAsset;
      
      public function FreeHero()
      {
         super();
         target = new Point();
         _speed = DataStorage.battleConfig.core.defaultHeroSpeed * getScale();
      }
      
      public function dispose() : void
      {
         view.dispose();
      }
      
      public function dropTexture() : void
      {
         if(asset != null && RsxGameAsset(asset).used == 0)
         {
         }
      }
      
      protected function getScale() : Number
      {
         return 0.75;
      }
      
      public function get isMoving() : Boolean
      {
         return movement != 0;
      }
      
      public function get xTarget() : Number
      {
         return target.x;
      }
      
      public function get yTarget() : Number
      {
         return target.y;
      }
      
      public function get speed() : Number
      {
         return _speed;
      }
      
      public function set speed(param1:Number) : void
      {
         _speed = param1;
      }
      
      public function init(param1:IHeroAsset, param2:Number = 1) : void
      {
         view.applyAsset(param1.getHeroData(getScale() * param2));
         this.asset = param1;
      }
      
      public function advanceTime(param1:Number) : void
      {
         move(param1);
         if(movement == 0 && view.canStrafe)
         {
            if(Math.random() < 0.002)
            {
               view.win();
            }
         }
         view.position.scale = 0.95 / (1 - position.y * 0.00075);
         view.position.x = (position.x - 450) * view.position.scale + 450;
         view.position.y = position.y;
         view.position.z = position.y;
         view.position.movement = movement;
         view.position.isMoveable = true;
         view.updatePosition();
      }
      
      public function isSameAsset(param1:IHeroAsset) : Boolean
      {
         return this.asset == param1;
      }
      
      public function distanceTo(param1:Number) : Number
      {
         return Math.abs(param1 - target.x);
      }
      
      public function targetY(param1:Number = NaN) : void
      {
         if(target.y != param1)
         {
            if(!isNaN(param1))
            {
               target.y = param1;
            }
            view.stopAny();
         }
      }
      
      public function targetPosition(param1:Number, param2:Number = NaN) : void
      {
         if(!isNaN(param1))
         {
            target.x = param1;
         }
         if(!isNaN(param2))
         {
            target.y = param2;
         }
         view.stopAny();
      }
      
      public function setPosition(param1:Number, param2:Number) : void
      {
         var _loc3_:* = param1;
         target.x = _loc3_;
         position.x = _loc3_;
         _loc3_ = param2;
         target.y = _loc3_;
         position.y = _loc3_;
      }
      
      public function setHappy() : void
      {
         view.win();
      }
      
      public function onDispose() : Signal
      {
         if(view.isDying)
         {
            return view.onDeath;
         }
         return null;
      }
      
      protected function move(param1:Number) : void
      {
         var _loc2_:* = Number(this._speed * param1);
         if(position.x < target.x - _loc2_)
         {
            view.position.direction = 1;
            position.x = position.x + _loc2_;
         }
         else if(position.x > target.x + _loc2_)
         {
            view.position.direction = -1;
            position.x = position.x - _loc2_;
         }
         else
         {
            _loc2_ = 0;
            target.x = position.x;
         }
         var _loc3_:* = Number(this._speed * param1 * 0.5);
         if(position.y < target.y - _loc3_)
         {
            position.y = position.y + _loc3_;
         }
         else if(position.y > target.y + _loc3_)
         {
            position.y = position.y - _loc3_;
         }
         else
         {
            _loc3_ = 0;
            target.y = position.y;
         }
         if(_loc2_ == 0 && _loc3_ == 0)
         {
            movement = 0;
         }
         else if(Math.abs(_loc2_) > Math.abs(_loc3_))
         {
            movement = 1;
         }
         else
         {
            movement = 2;
         }
      }
   }
}
