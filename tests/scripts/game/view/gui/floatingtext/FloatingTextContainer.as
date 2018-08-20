package game.view.gui.floatingtext
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import game.mediator.gui.popup.PopupMediator;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.Sprite;
   
   public class FloatingTextContainer extends Sprite implements IAnimatable
   {
      
      public static var globalContainer:FloatingTextContainer;
      
      private static const rect:Rectangle = new Rectangle();
       
      
      private var pool:Vector.<FloatingTextRecord>;
      
      private var active:Vector.<FloatingTextRecord>;
      
      public function FloatingTextContainer()
      {
         pool = new Vector.<FloatingTextRecord>();
         active = new Vector.<FloatingTextRecord>();
         super();
         touchable = false;
      }
      
      public static function show(param1:String, param2:PopupMediator = null, param3:Point = null, param4:Number = NaN) : void
      {
         if(!globalContainer)
         {
            globalContainer = new FloatingTextContainer();
            Starling.current.stage.addChild(globalContainer);
         }
         if(!param3)
         {
            param3 = getStageMousePoint();
         }
         globalContainer.addText(param3.x,param3.y,param4,param1,param2);
      }
      
      public static function showInDisplayObjectCenter(param1:DisplayObject, param2:Number, param3:Number, param4:String, param5:PopupMediator = null, param6:Number = NaN) : void
      {
         if(!globalContainer)
         {
            globalContainer = new FloatingTextContainer();
            Starling.current.stage.addChild(globalContainer);
         }
         globalContainer.fromObject_horizontalCentered(param1,param2,param3,param4,param5,param6);
      }
      
      private static function getStageMousePoint() : Point
      {
         var _loc6_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc4_:* = null;
         var _loc2_:Number = NaN;
         var _loc1_:Number = NaN;
         var _loc3_:Starling = Starling.current;
         if(_loc3_)
         {
            _loc6_ = _loc3_.nativeStage.mouseX;
            _loc5_ = _loc3_.nativeStage.mouseY;
            _loc4_ = _loc3_.viewPort;
            _loc2_ = _loc3_.stage.stageWidth * (_loc6_ - _loc4_.x) / _loc4_.width;
            _loc1_ = _loc3_.stage.stageHeight * (_loc5_ - _loc4_.y) / _loc4_.height;
            return new Point(_loc2_,_loc1_);
         }
         return new Point(0,0);
      }
      
      override public function dispose() : void
      {
         super.dispose();
         Starling.juggler.remove(this);
      }
      
      public function fromObject_horizontalCentered(param1:DisplayObject, param2:Number, param3:Number, param4:String, param5:PopupMediator = null, param6:Number = NaN) : void
      {
         var _loc7_:* = null;
         var _loc8_:* = null;
         if(param1.stage)
         {
            _loc7_ = param1.getBounds(this,_loc7_);
            if(pool.length > 0)
            {
               _loc8_ = pool.pop();
               _loc8_.removeRequired = false;
            }
            else
            {
               _loc8_ = new FloatingTextRecord(1.6);
            }
            _loc8_.init(_loc7_.x + _loc7_.width * 0.5 + param2,_loc7_.y + param3,param6,param4,param5);
            if(active.length == 0)
            {
               Starling.juggler.add(this);
            }
            addChild(_loc8_.label);
            active.push(_loc8_);
         }
      }
      
      public function addText(param1:Number, param2:Number, param3:Number, param4:String, param5:PopupMediator = null) : void
      {
         var _loc6_:* = null;
         if(pool.length > 0)
         {
            _loc6_ = pool.pop();
            _loc6_.removeRequired = false;
         }
         else
         {
            _loc6_ = new FloatingTextRecord(1.6);
         }
         Starling.juggler.add(this);
         _loc6_.init(param1,param2,param3,param4,param5);
         addChild(_loc6_.label);
         active.push(_loc6_);
      }
      
      public function advanceTime(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc5_:int = 0;
         var _loc4_:* = active;
         for each(var _loc2_ in active)
         {
            _loc2_.timeElapsed = _loc2_.timeElapsed + param1;
            _loc3_ = _loc2_.timeElapsed / _loc2_.duration;
            if(_loc3_ >= 1 || _loc2_.removeRequired)
            {
               _loc2_.owner = null;
               removeChild(_loc2_.label);
               active.splice(active.indexOf(_loc2_),1);
               pool.push(_loc2_);
               if(active.length == 0)
               {
                  Starling.juggler.remove(this);
               }
            }
            else
            {
               _loc2_.label.y = _loc2_.label.y - 100 * param1 * (1 - _loc3_) * (1 - _loc3_);
               _loc2_.label.alpha = 1 - _loc3_ * _loc3_;
            }
         }
      }
   }
}

import game.mediator.gui.popup.PopupMediator;
import game.view.gui.components.GameLabel;
import game.view.popup.theme.LabelStyle;

class FloatingTextRecord
{
    
   
   public var timeElapsed:Number;
   
   public var duration:Number;
   
   public var label:GameLabel;
   
   public var removeRequired:Boolean;
   
   private var _owner:PopupMediator;
   
   function FloatingTextRecord(param1:Number)
   {
      label = LabelStyle.buttonLabel_size18_skillUpgrade();
      super();
      this.duration = param1;
   }
   
   public function get owner() : PopupMediator
   {
      return _owner;
   }
   
   public function set owner(param1:PopupMediator) : void
   {
      if(_owner)
      {
         _owner.signal_dispose.remove(handler_ownerDispose);
      }
      _owner = param1;
      if(_owner)
      {
         _owner.signal_dispose.add(handler_ownerDispose);
      }
   }
   
   public function init(param1:Number, param2:Number, param3:Number, param4:String, param5:PopupMediator = null) : void
   {
      this.owner = param5;
      timeElapsed = 0;
      label.alpha = 1;
      label.width = param3;
      label.text = param4;
      label.validate();
      label.x = param1 - label.width * 0.5;
      label.y = param2;
   }
   
   private function handler_ownerDispose() : void
   {
      removeRequired = true;
   }
}
