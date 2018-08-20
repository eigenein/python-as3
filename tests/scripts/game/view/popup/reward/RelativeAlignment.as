package game.view.popup.reward
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class RelativeAlignment
   {
       
      
      public var paddingLeft:Number = 0;
      
      public var paddingRight:Number = 0;
      
      public var paddingTop:Number = 0;
      
      public var paddingBottom:Number = 0;
      
      public var alignHorizontal:String;
      
      public var alignVertical:String;
      
      public var internalAlignment:Boolean;
      
      public var useFloatCoords:Boolean = false;
      
      public function RelativeAlignment(param1:String = null, param2:String = null, param3:Boolean = true)
      {
         super();
         this.alignHorizontal = param1;
         this.alignVertical = param2;
         this.internalAlignment = param3;
      }
      
      public function set padding(param1:Number) : void
      {
         paddingBottom = param1;
         paddingTop = param1;
         paddingRight = param1;
         paddingLeft = param1;
      }
      
      public function set paddingHorizontal(param1:Number) : void
      {
         paddingRight = param1;
         paddingLeft = param1;
      }
      
      public function set paddingVertical(param1:Number) : void
      {
         paddingBottom = param1;
         paddingTop = param1;
      }
      
      public function apply(param1:DisplayObject, param2:DisplayObject) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc12_:* = null;
         var _loc4_:DisplayObjectContainer = param1.parent;
         if(!_loc4_)
         {
            return;
            §§push(trace("Could not align object without parent"));
         }
         else
         {
            var _loc5_:Rectangle = param2.getBounds(_loc4_);
            var _loc8_:Rectangle = param1.getBounds(param1);
            var _loc9_:Number = _loc8_.x - paddingLeft;
            var _loc11_:Number = _loc8_.x + _loc8_.width + paddingRight;
            var _loc3_:Number = _loc8_.y - paddingTop;
            var _loc10_:Number = _loc8_.y + _loc8_.height + paddingBottom;
            if(alignHorizontal == "left")
            {
               if(internalAlignment)
               {
                  _loc6_ = _loc5_.x + _loc9_;
               }
               else
               {
                  _loc6_ = _loc5_.x - _loc11_;
               }
            }
            else if(alignHorizontal == "right")
            {
               if(internalAlignment)
               {
                  _loc6_ = _loc5_.x + _loc5_.width - _loc11_;
               }
               else
               {
                  _loc6_ = _loc5_.x + _loc5_.width - _loc9_;
               }
            }
            else if(alignHorizontal == "center")
            {
               _loc6_ = _loc5_.x + _loc5_.width * 0.5 - (_loc9_ + _loc11_) * 0.5;
            }
            else
            {
               _loc12_ = param2.localToGlobal(new Point());
               _loc12_ = _loc4_.globalToLocal(_loc12_);
               _loc6_ = _loc12_.x + paddingLeft;
            }
            if(alignVertical == "top")
            {
               if(internalAlignment)
               {
                  _loc7_ = _loc5_.y + _loc3_;
               }
               else
               {
                  _loc7_ = _loc5_.y - _loc10_;
               }
            }
            else if(alignVertical == "bottom")
            {
               if(internalAlignment)
               {
                  _loc7_ = _loc5_.y + _loc5_.height - _loc10_;
               }
               else
               {
                  _loc7_ = _loc5_.y + _loc5_.height - _loc3_;
               }
            }
            else if(alignVertical == "middle")
            {
               _loc7_ = _loc5_.y + _loc5_.height * 0.5 - (_loc3_ + _loc10_) * 0.5;
            }
            else
            {
               if(!_loc12_)
               {
                  _loc12_ = param2.localToGlobal(new Point());
                  _loc12_ = _loc4_.globalToLocal(_loc12_);
               }
               _loc7_ = _loc12_.y + paddingTop;
            }
            if(useFloatCoords)
            {
               param1.x = _loc6_;
               param1.y = _loc7_;
            }
            else
            {
               param1.x = int(_loc6_);
               param1.y = int(_loc7_);
            }
            return;
         }
      }
   }
}
