package game.view.gui.overlay.offer
{
   import engine.core.utils.MathUtil;
   import feathers.controls.LayoutGroup;
   import feathers.layout.VerticalLayout;
   import flash.geom.Point;
   import game.model.user.specialoffer.ISpecialOfferSideBarIconFactory;
   import game.model.user.specialoffer.SpecialOfferIconDescription;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class SpecialOfferSideBarBase extends LayoutGroup
   {
      
      private static const GAP:Number = 15;
       
      
      private var mediator:SpecialOfferSideBarMediatorBase;
      
      private var floatingContainer:LayoutGroup;
      
      private var touchPoint:Point;
      
      private var xProgress:Number = 0;
      
      private var yIndex:Number = 0;
      
      private const specialOfferButtons:Array = [];
      
      public function SpecialOfferSideBarBase(param1:SpecialOfferSideBarMediatorBase)
      {
         floatingContainer = new LayoutGroup();
         touchPoint = new Point(-50,0);
         super();
         width = 82;
         height = 300;
         layout = new VerticalLayout();
         (layout as VerticalLayout).verticalAlign = "middle";
         addChild(floatingContainer);
         this.mediator = param1;
      }
      
      override public function dispose() : void
      {
         Starling.current.stage.removeEventListener("touch",handler_touch);
         super.dispose();
      }
      
      protected function addElement(param1:DisplayObject) : void
      {
         floatingContainer.addChild(param1);
      }
      
      protected function removeElement(param1:DisplayObject) : void
      {
         floatingContainer.removeChild(param1);
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mediator.signal_update.add(handler_updateSpecialOfferButton);
         handler_updateSpecialOfferButton();
         addEventListener("enterFrame",handler_enterFrame);
         stage.addEventListener("touch",handler_touch);
         handler_enterFrame(null);
      }
      
      protected function createIcon(param1:SpecialOfferIconDescription) : void
      {
         var _loc2_:* = null;
         if(param1.specialOffer is ISpecialOfferSideBarIconFactory)
         {
            _loc2_ = (param1.specialOffer as ISpecialOfferSideBarIconFactory).createSideBarIcon();
         }
         else
         {
            _loc2_ = new SpecialOfferSideBarIconClip();
         }
         _loc2_.setIcon(param1);
         _loc2_.signal_click.add(mediator.action_specialOfferIconSelect);
         addElement(_loc2_.graphics);
         specialOfferButtons[param1.specialOffer.id] = _loc2_;
      }
      
      protected function deleteIcon(param1:int) : void
      {
         var _loc2_:SpecialOfferClipButton = specialOfferButtons[param1];
         _loc2_.dispose();
         var _loc3_:SpecialOfferSideBarFadeAway = new SpecialOfferSideBarFadeAway(null,_loc2_.graphics);
      }
      
      private function offerIsPresented(param1:int, param2:Vector.<SpecialOfferIconDescription>) : Boolean
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      protected function handler_updateSpecialOfferButton() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Vector.<SpecialOfferIconDescription> = mediator.specialOfferIcons;
         var _loc6_:int = 0;
         var _loc5_:* = _loc4_;
         for each(var _loc1_ in _loc4_)
         {
            if(specialOfferButtons[_loc1_.specialOffer.id] == undefined)
            {
               _loc2_ = 0;
               while(_loc2_ < 1)
               {
                  createIcon(_loc1_);
                  _loc2_++;
               }
               continue;
            }
         }
         var _loc8_:int = 0;
         var _loc7_:* = specialOfferButtons;
         for(var _loc3_ in specialOfferButtons)
         {
            if(!offerIsPresented(_loc3_,_loc4_))
            {
               deleteIcon(_loc3_);
            }
         }
      }
      
      private function handler_touch(param1:TouchEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1.touches;
         for each(var _loc2_ in param1.touches)
         {
            _loc2_.getLocation(this,this.touchPoint);
         }
      }
      
      private function handler_enterFrame(param1:Event) : void
      {
         var _loc18_:int = 0;
         var _loc5_:* = NaN;
         var _loc20_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc26_:* = null;
         var _loc2_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc11_:int = floatingContainer.numChildren;
         var _loc7_:* = 0.3;
         var _loc22_:Number = width;
         var _loc23_:* = 0;
         var _loc9_:* = 15;
         var _loc15_:* = 1;
         var _loc12_:Number = MathUtil.clamp(5.5 / (_loc11_ + 2.5),0,1);
         var _loc21_:Number = MathUtil.clamp(MathUtil.map(touchPoint.x,-25,5,-2,3),0,1);
         if(_loc21_ > 0)
         {
            xProgress = xProgress * 0.5 + _loc21_ * 0.5;
         }
         else
         {
            xProgress = xProgress * 0.6 + _loc21_ * 0.4;
         }
         var _loc4_:Number = _loc12_ * 15 * (_loc11_ - 1);
         _loc18_ = 0;
         while(_loc18_ < _loc11_)
         {
            _loc26_ = floatingContainer.getChildAt(_loc18_);
            _loc4_ = _loc4_ + _loc12_ * _loc26_.getBounds(_loc26_).height * _loc26_.alpha;
            _loc18_++;
         }
         var _loc10_:Number = _loc4_ - height > 0?-(_loc4_ - height) * 0.5:0;
         var _loc8_:Boolean = false;
         var _loc6_:Number = _loc4_ / _loc11_;
         if(_loc11_ == 0)
         {
            return;
         }
         var _loc14_:Number = _loc12_ * floatingContainer.getChildAt(0).getBounds(floatingContainer.getChildAt(0)).height * 0.5;
         var _loc19_:Number = _loc12_ * floatingContainer.getChildAt(_loc11_ - 1).getBounds(floatingContainer.getChildAt(_loc11_ - 1)).height * 0.5;
         if(touchPoint.x >= -25)
         {
            _loc5_ = _loc10_;
            _loc20_ = _loc10_ + _loc4_;
            _loc13_ = _loc11_ * (touchPoint.y - _loc5_) / (_loc20_ - _loc5_);
            yIndex = yIndex * 0.5 + _loc13_ * 0.5;
         }
         var _loc25_:* = _loc10_;
         _loc23_ = _loc25_;
         _loc18_ = 0;
         while(_loc18_ < _loc11_)
         {
            _loc26_ = floatingContainer.getChildAt(_loc18_);
            _loc2_ = Math.abs(MathUtil.clamp(yIndex,0.5,_loc11_ - 0.5) - _loc18_ - 0.5);
            _loc2_ = MathUtil.clamp(1 + _loc7_ - _loc2_,0,1) / 1;
            _loc24_ = xProgress * _loc2_;
            _loc3_ = _loc12_ + (_loc15_ - _loc12_) * _loc24_;
            if(_loc18_ > 0)
            {
               _loc23_ = Number(_loc23_ + _loc9_ * _loc3_ * 0.5 * _loc26_.alpha);
            }
            var _loc27_:* = _loc3_;
            _loc26_.scaleY = _loc27_;
            _loc26_.scaleX = _loc27_;
            _loc26_.y = _loc23_;
            if(_loc8_)
            {
               _loc23_ = Number(_loc23_ + _loc6_ * _loc26_.alpha * _loc3_);
            }
            else
            {
               _loc23_ = Number(_loc23_ + _loc26_.height * _loc26_.alpha);
            }
            if(_loc18_ < _loc11_ - 1)
            {
               _loc23_ = Number(_loc23_ + _loc9_ * _loc3_ * 0.5 * _loc26_.alpha);
            }
            _loc26_.x = _loc22_ - _loc26_.width;
            _loc18_++;
         }
         _loc14_ = _loc14_ * (1 - _loc12_);
         _loc19_ = _loc19_ * (1 - _loc12_);
         var _loc17_:Number = MathUtil.clamp(MathUtil.map(yIndex,0.5,_loc11_ - 0.5,0,1),0,1);
         var _loc16_:Number = (-_loc14_ + (_loc4_ - (_loc23_ - _loc25_) + _loc14_ - _loc19_) * _loc17_) * xProgress;
         _loc18_ = 0;
         while(_loc18_ < _loc11_)
         {
            _loc26_ = floatingContainer.getChildAt(_loc18_);
            _loc26_.y = _loc26_.y + _loc16_;
            if(_loc26_.scaleX == 1)
            {
               _loc26_.y = int(_loc26_.y);
            }
            _loc18_++;
         }
      }
   }
}
