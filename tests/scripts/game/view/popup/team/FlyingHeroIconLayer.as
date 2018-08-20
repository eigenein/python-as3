package game.view.popup.team
{
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.HeroPortrait;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class FlyingHeroIconLayer implements IAnimatable
   {
       
      
      private const pool:Vector.<FlyingHeroPortrait> = new Vector.<FlyingHeroPortrait>();
      
      private const active:Vector.<FlyingHeroPortrait> = new Vector.<FlyingHeroPortrait>();
      
      public const graphics:Sprite = new Sprite();
      
      public function FlyingHeroIconLayer()
      {
         super();
         Starling.juggler.add(this);
      }
      
      public function dispose() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:int = active.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = active[_loc2_];
            graphics.removeChild(_loc3_.view);
            _loc3_.view.dispose();
            _loc2_++;
         }
         _loc1_ = pool.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = pool[_loc2_];
            _loc3_.view.dispose();
            _loc2_++;
         }
         pool.length = 0;
         Starling.juggler.remove(this);
      }
      
      public function add(param1:UnitEntryValueObject, param2:DisplayObject, param3:DisplayObject, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number = NaN, param9:Number = NaN) : void
      {
         var _loc11_:* = null;
         if(pool.length > 0)
         {
            _loc11_ = pool.pop();
         }
         else
         {
            _loc11_ = new FlyingHeroPortrait();
         }
         if(!_loc11_.portrait)
         {
            _loc11_.portrait = new HeroPortrait();
         }
         _loc11_.portrait.data = param1;
         _loc11_.portrait.validate();
         var _loc10_:Rectangle = param2.getBounds(graphics);
         _loc11_.source.x = _loc10_.x;
         _loc11_.source.y = _loc10_.y;
         _loc11_.targetView = param3;
         _loc11_.time = 0;
         _loc11_.duration = param7;
         _loc11_.maxYDelta = param8;
         _loc11_.minYDelta = param9;
         _loc11_.alphaPower = param4;
         _loc11_.xPower = param5;
         _loc11_.yPower = param6;
         graphics.addChild(_loc11_.view);
         active.push(_loc11_);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:int = active.length;
         var _loc2_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            var _loc6_:* = active[_loc4_];
            active[_loc4_ - _loc2_] = _loc6_;
            _loc5_ = _loc6_;
            _loc5_.time = _loc5_.time + param1;
            if(_loc5_.time > _loc5_.duration)
            {
               _loc2_++;
               pool[pool.length] = _loc5_;
               graphics.removeChild(_loc5_.view,true);
            }
            else
            {
               updateItem(_loc5_,param1);
            }
            _loc4_++;
         }
         active.length = _loc3_ - _loc2_;
      }
      
      protected function updateItem(param1:FlyingHeroPortrait, param2:Number) : void
      {
         var _loc6_:* = null;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc12_:Number = param1.time / param1.duration;
         var _loc10_:Number = param1.time / param1.duration;
         var _loc13_:Number = 1 - Math.abs(_loc10_ * _loc10_ - 0.5) * 2;
         var _loc14_:Number = 1 - Math.abs(_loc10_ - 0.5) * 2;
         var _loc11_:Number = Math.pow(_loc14_,param1.alphaPower);
         if(param1.targetView.parent)
         {
            _loc6_ = param1.targetView.getBounds(graphics);
            _loc8_ = _loc6_.x;
            _loc7_ = _loc6_.y;
            if(param1.maxYDelta === param1.maxYDelta && _loc7_ > param1.source.y + param1.maxYDelta)
            {
               _loc8_ = param1.source.x + param1.maxYDelta;
               _loc7_ = param1.source.y + param1.maxYDelta;
            }
            if(param1.minYDelta === param1.minYDelta && _loc7_ < param1.source.y + param1.minYDelta)
            {
               _loc8_ = param1.source.x + param1.minYDelta * 0.3;
               _loc7_ = param1.source.y + param1.minYDelta;
            }
            _loc5_ = Math.sqrt((_loc8_ - param1.source.x) * (_loc8_ - param1.source.x) + (_loc7_ - param1.source.y) * (_loc7_ - param1.source.y));
            _loc14_ = Math.sin(_loc10_ * 3.14159265358979);
            _loc9_ = 1 - 0.3 * _loc14_ * (1 - 150 / (150 + _loc5_));
            var _loc15_:* = _loc9_;
            param1.view.scaleY = _loc15_;
            param1.view.scaleX = _loc15_;
            _loc3_ = Math.pow(_loc12_,param1.xPower);
            _loc4_ = Math.pow(_loc12_,param1.yPower);
            param1.view.x = param1.source.x * (1 - _loc3_) + _loc3_ * _loc8_ + param1.view.width / _loc9_ * (1 - _loc9_) * 0.5;
            param1.view.y = param1.source.y * (1 - _loc4_) + _loc4_ * _loc7_ + param1.view.height / _loc9_ * (1 - _loc9_) * 0.5;
            param1.view.alpha = _loc11_;
         }
         else
         {
            param1.view.alpha = 0;
         }
      }
   }
}

import flash.geom.Point;
import game.view.gui.components.HeroPortrait;
import starling.display.DisplayObject;

class FlyingHeroPortrait
{
    
   
   public var portrait:HeroPortrait;
   
   public var target:Point;
   
   public var source:Point;
   
   public var time:Number = 0;
   
   public var targetView:DisplayObject;
   
   public var duration:Number = 0.5;
   
   public var maxYDelta:Number;
   
   public var minYDelta:Number;
   
   public var alphaPower:Number;
   
   public var xPower:Number;
   
   public var yPower:Number;
   
   function FlyingHeroPortrait()
   {
      target = new Point();
      source = new Point();
      super();
   }
   
   public function get view() : DisplayObject
   {
      return portrait;
   }
}
