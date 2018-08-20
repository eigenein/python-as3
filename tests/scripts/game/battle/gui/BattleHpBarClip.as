package game.battle.gui
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.animation.ZSortedSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.IGuiClip;
   import engine.core.clipgui.INeedNestedParsing;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Quad;
   
   public class BattleHpBarClip extends ZSortedSprite implements IGuiClip, INeedNestedParsing
   {
       
      
      private var maxValue:Number;
      
      private var value:Number;
      
      private var smoothValue:Number = 0;
      
      private var oldValue:Number = 0;
      
      private var oldSmoothValue:Number = 0;
      
      private var minOldSmoothValue:Number = 0;
      
      private var maxBarWidth:Number;
      
      private var oldValues:Vector.<BattleHpBarClipOldValue>;
      
      private var notches:Vector.<Quad>;
      
      private var notchesWidth:Vector.<int>;
      
      public var background:GuiClipScale3Image;
      
      public var differenceBar:GuiClipImage;
      
      public var positiveDifferenceBar:GuiClipImage;
      
      public var bar:GuiClipScale3Image;
      
      private var megaNotchesWidth:int = 1;
      
      public function BattleHpBarClip()
      {
         oldValues = new Vector.<BattleHpBarClipOldValue>();
         notches = new Vector.<Quad>();
         notchesWidth = new Vector.<int>();
         super();
      }
      
      public function get graphics() : DisplayObject
      {
         return this;
      }
      
      public function get container() : DisplayObjectContainer
      {
         return this;
      }
      
      public function setNode(param1:Node) : void
      {
         maxBarWidth = bar.image.width;
      }
      
      public function defineMaxValue(param1:Number) : void
      {
         var _loc6_:int = 0;
         _loc6_ = 1000000;
         var _loc2_:int = 0;
         _loc2_ = 100000;
         var _loc4_:int = 0;
         _loc4_ = 10000;
         var _loc5_:int = 0;
         _loc5_ = 2000;
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc7_:* = false;
         var _loc3_:* = null;
         maxValue = param1;
         if(notches)
         {
            if(maxValue > 1000000 * 2)
            {
               setupMegaNotches2(1000000);
               return;
            }
            if(maxValue > 100000 * 2)
            {
               setupMegaNotches(100000);
               return;
            }
            if(maxValue < 2000 * 2)
            {
               return;
            }
            _loc10_ = notches.length;
            _loc8_ = 0;
            _loc9_ = 2000;
            while(_loc9_ < maxValue)
            {
               _loc7_ = _loc9_ % 10000 == 0;
               if(!(!_loc7_ && maxValue > 10000 * 3))
               {
                  if(_loc8_ >= _loc10_)
                  {
                     _loc3_ = new Quad(1,1,0);
                     addChild(_loc3_);
                     notches[_loc8_] = _loc3_;
                  }
                  else
                  {
                     _loc3_ = notches[_loc8_];
                  }
                  _loc8_++;
                  _loc3_.alpha = !!_loc7_?0.4:0.3;
                  _loc3_.height = !!_loc7_?bar.image.height:Number(bar.image.height * 0.6);
                  _loc3_.x = bar.image.x + maxBarWidth * _loc9_ / maxValue;
                  _loc3_.y = bar.image.y;
                  notchesWidth[_loc8_ - 1] = _loc3_.width;
               }
               _loc9_ = _loc9_ + 2000;
            }
            if(_loc8_ < _loc10_)
            {
               _loc9_ = _loc8_;
               while(_loc9_ < _loc10_)
               {
                  notches[int(_loc9_)].removeFromParent(true);
                  _loc9_++;
               }
               notches.length = _loc8_;
               notchesWidth.length = _loc8_;
            }
         }
      }
      
      public function defineValue(param1:Number, param2:Number) : void
      {
         oldValue = param1;
         minOldSmoothValue = param1;
         oldSmoothValue = param1;
         smoothValue = param1;
         this.value = param1;
         if(param2 != this.maxValue)
         {
            defineMaxValue(param2);
         }
      }
      
      public function setValue(param1:Number, param2:Number) : void
      {
         if(param2 != this.maxValue)
         {
            defineMaxValue(param2);
         }
         if(this.value != param1)
         {
            if(param1 < this.value)
            {
               oldValues.push(new BattleHpBarClipOldValue(this.value,0.8));
            }
            else
            {
               oldValues.push(new BattleHpBarClipOldValue(this.value,0.8));
               oldValue = param1;
               if(oldValue > oldSmoothValue || !visible)
               {
                  oldSmoothValue = oldValue;
               }
               if(!visible)
               {
                  oldSmoothValue = oldValue;
               }
            }
            this.value = param1;
         }
      }
      
      private function setupMegaNotches2(param1:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:* = null;
         var _loc6_:int = param1 * 0.5;
         var _loc5_:int = notches.length;
         var _loc3_:int = 0;
         megaNotchesWidth = maxBarWidth * _loc6_ / maxValue;
         _loc4_ = param1;
         while(_loc4_ < maxValue)
         {
            if(_loc3_ >= _loc5_)
            {
               _loc2_ = new Quad(1,1,0);
               addChild(_loc2_);
               notches[_loc3_] = _loc2_;
            }
            else
            {
               _loc2_ = notches[_loc3_];
            }
            _loc3_++;
            _loc2_.alpha = 0.65;
            _loc2_.height = bar.image.height - 2;
            _loc2_.x = Math.round(bar.image.x + maxBarWidth * (_loc4_ - param1) / maxValue) + 2;
            _loc2_.width = Math.round(bar.image.x + maxBarWidth * _loc4_ / maxValue) - _loc2_.x;
            _loc2_.y = bar.image.y + 1;
            notchesWidth[_loc3_ - 1] = _loc2_.width;
            _loc4_ = _loc4_ + param1;
         }
         if(_loc3_ < _loc5_)
         {
            _loc4_ = _loc3_;
            while(_loc4_ < _loc5_)
            {
               notches[int(_loc4_)].removeFromParent(true);
               _loc4_++;
            }
            notches.length = _loc3_;
            notchesWidth.length = _loc3_;
         }
      }
      
      private function setupMegaNotches(param1:int) : void
      {
         var _loc4_:Number = NaN;
         var _loc2_:* = null;
         var _loc5_:int = notches.length;
         var _loc3_:int = 0;
         megaNotchesWidth = maxBarWidth / maxValue;
         _loc4_ = param1;
         while(_loc4_ < maxValue)
         {
            if(_loc3_ >= _loc5_)
            {
               _loc2_ = new Quad(1,1,0);
               addChild(_loc2_);
               notches[_loc3_] = _loc2_;
            }
            else
            {
               _loc2_ = notches[_loc3_];
            }
            _loc3_++;
            _loc2_.alpha = 0.65;
            _loc2_.height = Math.ceil(bar.image.height * 0.5);
            _loc2_.x = Math.round(bar.image.x + maxBarWidth * (_loc4_ - param1) / maxValue);
            _loc2_.width = Math.round(bar.image.x + maxBarWidth * _loc4_ / maxValue) - _loc2_.x;
            _loc2_.y = bar.image.y + (bar.image.height - _loc2_.height) * (_loc3_ % 2);
            notchesWidth[_loc3_ - 1] = _loc2_.width;
            _loc4_ = _loc4_ + param1;
         }
         if(_loc3_ < _loc5_)
         {
            _loc4_ = _loc3_;
            while(_loc4_ < _loc5_)
            {
               notches[int(_loc4_)].removeFromParent(true);
               _loc4_++;
            }
            notches.length = _loc3_;
            notchesWidth.length = _loc3_;
         }
      }
      
      public function advanceTime(param1:Number) : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
   }
}

class BattleHpBarClipOldValue
{
    
   
   public var value:Number;
   
   public var timeLeft:Number;
   
   function BattleHpBarClipOldValue(param1:Number, param2:Number)
   {
      super();
      this.value = param1;
      this.timeLeft = param2;
   }
}
