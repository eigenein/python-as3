package feathers.layout
{
   import feathers.core.IFeathersControl;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class AnchorLayout extends EventDispatcher implements ILayout
   {
      
      protected static const CIRCULAR_REFERENCE_ERROR:String = "It is impossible to create this layout due to a circular reference in the AnchorLayoutData.";
      
      private static const HELPER_POINT:Point = new Point();
       
      
      protected var _helperVector1:Vector.<DisplayObject>;
      
      protected var _helperVector2:Vector.<DisplayObject>;
      
      public function AnchorLayout()
      {
         _helperVector1 = new Vector.<DisplayObject>(0);
         _helperVector2 = new Vector.<DisplayObject>(0);
         super();
      }
      
      public function get requiresLayoutOnScroll() : Boolean
      {
         return false;
      }
      
      public function layout(param1:Vector.<DisplayObject>, param2:ViewPortBounds = null, param3:LayoutBoundsResult = null) : LayoutBoundsResult
      {
         var _loc8_:Number = !!param2?param2.x:0;
         var _loc9_:Number = !!param2?param2.y:0;
         var _loc5_:Number = !!param2?param2.minWidth:0;
         var _loc6_:Number = !!param2?param2.minHeight:0;
         var _loc15_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc10_:Number = !!param2?param2.maxHeight:Infinity;
         var _loc7_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc13_:Number = !!param2?param2.explicitHeight:NaN;
         var _loc11_:* = _loc7_;
         var _loc14_:* = _loc13_;
         var _loc4_:* = _loc7_ !== _loc7_;
         var _loc12_:* = _loc13_ !== _loc13_;
         if(_loc4_ || _loc12_)
         {
            this.validateItems(param1,true);
            this.measureViewPort(param1,_loc11_,_loc14_,HELPER_POINT);
            if(_loc4_)
            {
               _loc11_ = Number(Math.min(_loc15_,Math.max(_loc5_,HELPER_POINT.x)));
            }
            if(_loc12_)
            {
               _loc14_ = Number(Math.min(_loc10_,Math.max(_loc6_,HELPER_POINT.y)));
            }
         }
         else
         {
            this.validateItems(param1,false);
         }
         this.layoutWithBounds(param1,_loc8_,_loc9_,_loc11_,_loc14_);
         this.measureContent(param1,_loc11_,_loc14_,HELPER_POINT);
         if(!param3)
         {
            param3 = new LayoutBoundsResult();
         }
         param3.contentWidth = HELPER_POINT.x;
         param3.contentHeight = HELPER_POINT.y;
         param3.viewPortWidth = _loc11_;
         param3.viewPortHeight = _loc14_;
         return param3;
      }
      
      public function getScrollPositionForIndex(param1:int, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number, param7:Point = null) : Point
      {
         if(!param7)
         {
            param7 = new Point();
         }
         param7.x = 0;
         param7.y = 0;
         return param7;
      }
      
      protected function measureViewPort(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Point = null) : Point
      {
         var _loc6_:* = NaN;
         this._helperVector1.length = 0;
         this._helperVector2.length = 0;
         HELPER_POINT.x = 0;
         HELPER_POINT.y = 0;
         var _loc7_:* = param1;
         var _loc8_:Vector.<DisplayObject> = this._helperVector1;
         this.measureVector(param1,_loc8_,HELPER_POINT);
         var _loc5_:Number = _loc8_.length;
         while(_loc5_ > 0)
         {
            if(_loc8_ == this._helperVector1)
            {
               _loc7_ = this._helperVector1;
               _loc8_ = this._helperVector2;
            }
            else
            {
               _loc7_ = this._helperVector2;
               _loc8_ = this._helperVector1;
            }
            this.measureVector(_loc7_,_loc8_,HELPER_POINT);
            _loc6_ = _loc5_;
            _loc5_ = _loc8_.length;
            if(_loc6_ == _loc5_)
            {
               this._helperVector1.length = 0;
               this._helperVector2.length = 0;
               throw new IllegalOperationError("It is impossible to create this layout due to a circular reference in the AnchorLayoutData.");
            }
         }
         this._helperVector1.length = 0;
         this._helperVector2.length = 0;
         if(!param4)
         {
            param4 = HELPER_POINT.clone();
         }
         return param4;
      }
      
      protected function measureVector(param1:Vector.<DisplayObject>, param2:Vector.<DisplayObject>, param3:Point = null) : Point
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc5_:Boolean = false;
         if(!param3)
         {
            param3 = new Point();
         }
         param2.length = 0;
         var _loc10_:int = param1.length;
         var _loc9_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc10_)
         {
            _loc6_ = param1[_loc8_];
            if(!(_loc6_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc6_).includeInLayout))
            {
               _loc4_ = null;
               if(_loc6_ is ILayoutDisplayObject)
               {
                  _loc7_ = ILayoutDisplayObject(_loc6_);
                  _loc4_ = _loc7_.layoutData as AnchorLayoutData;
               }
               _loc5_ = !_loc4_ || this.isReadyForLayout(_loc4_,_loc8_,param1,param2);
               if(!_loc5_)
               {
                  param2[_loc9_] = _loc6_;
                  _loc9_++;
               }
               else
               {
                  this.measureItem(_loc6_,param3);
               }
            }
            _loc8_++;
         }
         return param3;
      }
      
      protected function measureItem(param1:DisplayObject, param2:Point) : void
      {
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc8_:Number = NaN;
         var _loc6_:* = Number(param2.x);
         var _loc5_:* = Number(param2.y);
         var _loc7_:Boolean = false;
         if(param1 is ILayoutDisplayObject)
         {
            _loc4_ = ILayoutDisplayObject(param1);
            _loc3_ = _loc4_.layoutData as AnchorLayoutData;
            if(_loc3_)
            {
               _loc8_ = this.measureItemHorizontally(_loc4_,_loc3_);
               if(_loc8_ > _loc6_)
               {
                  _loc6_ = _loc8_;
               }
               _loc8_ = this.measureItemVertically(_loc4_,_loc3_);
               if(_loc8_ > _loc5_)
               {
                  _loc5_ = _loc8_;
               }
               _loc7_ = true;
            }
         }
         if(!_loc7_)
         {
            _loc8_ = param1.x - param1.pivotX + param1.width;
            if(_loc8_ > _loc6_)
            {
               _loc6_ = _loc8_;
            }
            _loc8_ = param1.y - param1.pivotY + param1.height;
            if(_loc8_ > _loc5_)
            {
               _loc5_ = _loc8_;
            }
         }
         param2.x = _loc6_;
         param2.y = _loc5_;
      }
      
      protected function measureItemHorizontally(param1:ILayoutDisplayObject, param2:AnchorLayoutData) : Number
      {
         var _loc7_:Number = NaN;
         var _loc4_:Number = param1.width;
         if(param2 && param1 is IFeathersControl)
         {
            _loc7_ = param2.percentWidth;
            this.doNothing();
            if(_loc7_ === _loc7_)
            {
               _loc4_ = IFeathersControl(param1).minWidth;
            }
         }
         var _loc6_:DisplayObject = DisplayObject(param1);
         var _loc3_:Number = this.getLeftOffset(_loc6_);
         var _loc5_:Number = this.getRightOffset(_loc6_);
         return _loc4_ + _loc3_ + _loc5_;
      }
      
      protected function measureItemVertically(param1:ILayoutDisplayObject, param2:AnchorLayoutData) : Number
      {
         var _loc3_:Number = NaN;
         var _loc6_:Number = param1.height;
         if(param2 && param1 is IFeathersControl)
         {
            _loc3_ = param2.percentHeight;
            this.doNothing();
            if(_loc3_ === _loc3_)
            {
               _loc6_ = IFeathersControl(param1).minHeight;
            }
         }
         var _loc7_:DisplayObject = DisplayObject(param1);
         var _loc4_:Number = this.getTopOffset(_loc7_);
         var _loc5_:Number = this.getBottomOffset(_loc7_);
         return _loc6_ + _loc4_ + _loc5_;
      }
      
      protected function doNothing() : void
      {
      }
      
      protected function getTopOffset(param1:DisplayObject) : Number
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc12_:* = NaN;
         var _loc8_:* = false;
         var _loc4_:* = null;
         var _loc6_:Number = NaN;
         var _loc9_:* = false;
         var _loc10_:* = null;
         var _loc3_:Number = NaN;
         var _loc13_:* = false;
         var _loc11_:* = null;
         var _loc7_:Number = NaN;
         if(param1 is ILayoutDisplayObject)
         {
            _loc5_ = ILayoutDisplayObject(param1);
            _loc2_ = _loc5_.layoutData as AnchorLayoutData;
            if(_loc2_)
            {
               _loc12_ = Number(_loc2_.top);
               _loc8_ = _loc12_ === _loc12_;
               if(_loc8_)
               {
                  _loc4_ = _loc2_.topAnchorDisplayObject;
                  if(_loc4_)
                  {
                     _loc12_ = Number(_loc12_ + (_loc4_.height + this.getTopOffset(_loc4_)));
                  }
                  else
                  {
                     return _loc12_;
                  }
               }
               else
               {
                  _loc12_ = 0;
               }
               _loc6_ = _loc2_.bottom;
               _loc9_ = _loc6_ === _loc6_;
               if(_loc9_)
               {
                  _loc10_ = _loc2_.bottomAnchorDisplayObject;
                  if(_loc10_)
                  {
                     _loc12_ = Number(Math.max(_loc12_,-_loc10_.height - _loc6_ + this.getTopOffset(_loc10_)));
                  }
               }
               _loc3_ = _loc2_.verticalCenter;
               _loc13_ = _loc3_ === _loc3_;
               if(_loc13_)
               {
                  _loc11_ = _loc2_.verticalCenterAnchorDisplayObject;
                  if(_loc11_)
                  {
                     _loc7_ = _loc3_ - Math.round((param1.height - _loc11_.height) / 2);
                     _loc12_ = Number(Math.max(_loc12_,_loc7_ + this.getTopOffset(_loc11_)));
                  }
                  else if(_loc3_ > 0)
                  {
                     return _loc3_ * 2;
                  }
               }
               return _loc12_;
            }
         }
         return 0;
      }
      
      protected function getRightOffset(param1:DisplayObject) : Number
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:* = NaN;
         var _loc6_:* = false;
         var _loc13_:* = null;
         var _loc9_:Number = NaN;
         var _loc11_:* = false;
         var _loc10_:* = null;
         var _loc5_:Number = NaN;
         var _loc12_:* = false;
         var _loc8_:* = null;
         var _loc7_:Number = NaN;
         if(param1 is ILayoutDisplayObject)
         {
            _loc3_ = ILayoutDisplayObject(param1);
            _loc2_ = _loc3_.layoutData as AnchorLayoutData;
            if(_loc2_)
            {
               _loc4_ = Number(_loc2_.right);
               _loc6_ = _loc4_ === _loc4_;
               if(_loc6_)
               {
                  _loc13_ = _loc2_.rightAnchorDisplayObject;
                  if(_loc13_)
                  {
                     _loc4_ = Number(_loc4_ + (_loc13_.width + this.getRightOffset(_loc13_)));
                  }
                  else
                  {
                     return _loc4_;
                  }
               }
               else
               {
                  _loc4_ = 0;
               }
               _loc9_ = _loc2_.left;
               _loc11_ = _loc9_ === _loc9_;
               if(_loc11_)
               {
                  _loc10_ = _loc2_.leftAnchorDisplayObject;
                  if(_loc10_)
                  {
                     _loc4_ = Number(Math.max(_loc4_,-_loc10_.width - _loc9_ + this.getRightOffset(_loc10_)));
                  }
               }
               _loc5_ = _loc2_.horizontalCenter;
               _loc12_ = _loc5_ === _loc5_;
               if(_loc12_)
               {
                  _loc8_ = _loc2_.horizontalCenterAnchorDisplayObject;
                  if(_loc8_)
                  {
                     _loc7_ = -_loc5_ - Math.round((param1.width - _loc8_.width) / 2);
                     _loc4_ = Number(Math.max(_loc4_,_loc7_ + this.getRightOffset(_loc8_)));
                  }
                  else if(_loc5_ < 0)
                  {
                     return -_loc5_ * 2;
                  }
               }
               return _loc4_;
            }
         }
         return 0;
      }
      
      protected function getBottomOffset(param1:DisplayObject) : Number
      {
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc6_:* = NaN;
         var _loc9_:* = false;
         var _loc10_:* = null;
         var _loc12_:Number = NaN;
         var _loc8_:* = false;
         var _loc4_:* = null;
         var _loc3_:Number = NaN;
         var _loc13_:* = false;
         var _loc11_:* = null;
         var _loc7_:Number = NaN;
         if(param1 is ILayoutDisplayObject)
         {
            _loc5_ = ILayoutDisplayObject(param1);
            _loc2_ = _loc5_.layoutData as AnchorLayoutData;
            if(_loc2_)
            {
               _loc6_ = Number(_loc2_.bottom);
               _loc9_ = _loc6_ === _loc6_;
               if(_loc9_)
               {
                  _loc10_ = _loc2_.bottomAnchorDisplayObject;
                  if(_loc10_)
                  {
                     _loc6_ = Number(_loc6_ + (_loc10_.height + this.getBottomOffset(_loc10_)));
                  }
                  else
                  {
                     return _loc6_;
                  }
               }
               else
               {
                  _loc6_ = 0;
               }
               _loc12_ = _loc2_.top;
               _loc8_ = _loc12_ === _loc12_;
               if(_loc8_)
               {
                  _loc4_ = _loc2_.topAnchorDisplayObject;
                  if(_loc4_)
                  {
                     _loc6_ = Number(Math.max(_loc6_,-_loc4_.height - _loc12_ + this.getBottomOffset(_loc4_)));
                  }
               }
               _loc3_ = _loc2_.verticalCenter;
               _loc13_ = _loc3_ === _loc3_;
               if(_loc13_)
               {
                  _loc11_ = _loc2_.verticalCenterAnchorDisplayObject;
                  if(_loc11_)
                  {
                     _loc7_ = -_loc3_ - Math.round((param1.height - _loc11_.height) / 2);
                     _loc6_ = Number(Math.max(_loc6_,_loc7_ + this.getBottomOffset(_loc11_)));
                  }
                  else if(_loc3_ < 0)
                  {
                     return -_loc3_ * 2;
                  }
               }
               return _loc6_;
            }
         }
         return 0;
      }
      
      protected function getLeftOffset(param1:DisplayObject) : Number
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc9_:* = NaN;
         var _loc11_:* = false;
         var _loc10_:* = null;
         var _loc4_:Number = NaN;
         var _loc6_:* = false;
         var _loc13_:* = null;
         var _loc5_:Number = NaN;
         var _loc12_:* = false;
         var _loc8_:* = null;
         var _loc7_:Number = NaN;
         if(param1 is ILayoutDisplayObject)
         {
            _loc3_ = ILayoutDisplayObject(param1);
            _loc2_ = _loc3_.layoutData as AnchorLayoutData;
            if(_loc2_)
            {
               _loc9_ = Number(_loc2_.left);
               _loc11_ = _loc9_ === _loc9_;
               if(_loc11_)
               {
                  _loc10_ = _loc2_.leftAnchorDisplayObject;
                  if(_loc10_)
                  {
                     _loc9_ = Number(_loc9_ + (_loc10_.width + this.getLeftOffset(_loc10_)));
                  }
                  else
                  {
                     return _loc9_;
                  }
               }
               else
               {
                  _loc9_ = 0;
               }
               _loc4_ = _loc2_.right;
               _loc6_ = _loc4_ === _loc4_;
               if(_loc6_)
               {
                  _loc13_ = _loc2_.rightAnchorDisplayObject;
                  if(_loc13_)
                  {
                     _loc9_ = Number(Math.max(_loc9_,-_loc13_.width - _loc4_ + this.getLeftOffset(_loc13_)));
                  }
               }
               _loc5_ = _loc2_.horizontalCenter;
               _loc12_ = _loc5_ === _loc5_;
               if(_loc12_)
               {
                  _loc8_ = _loc2_.horizontalCenterAnchorDisplayObject;
                  if(_loc8_)
                  {
                     _loc7_ = _loc5_ - Math.round((param1.width - _loc8_.width) / 2);
                     _loc9_ = Number(Math.max(_loc9_,_loc7_ + this.getLeftOffset(_loc8_)));
                  }
                  else if(_loc5_ > 0)
                  {
                     return _loc5_ * 2;
                  }
               }
               return _loc9_;
            }
         }
         return 0;
      }
      
      protected function layoutWithBounds(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Number, param5:Number) : void
      {
         var _loc7_:* = NaN;
         this._helperVector1.length = 0;
         this._helperVector2.length = 0;
         var _loc8_:* = param1;
         var _loc9_:Vector.<DisplayObject> = this._helperVector1;
         this.layoutVector(param1,_loc9_,param2,param3,param4,param5);
         var _loc6_:Number = _loc9_.length;
         while(_loc6_ > 0)
         {
            if(_loc9_ == this._helperVector1)
            {
               _loc8_ = this._helperVector1;
               _loc9_ = this._helperVector2;
            }
            else
            {
               _loc8_ = this._helperVector2;
               _loc9_ = this._helperVector1;
            }
            this.layoutVector(_loc8_,_loc9_,param2,param3,param4,param5);
            _loc7_ = _loc6_;
            _loc6_ = _loc9_.length;
            if(_loc7_ == _loc6_)
            {
               this._helperVector1.length = 0;
               this._helperVector2.length = 0;
               throw new IllegalOperationError("It is impossible to create this layout due to a circular reference in the AnchorLayoutData.");
            }
         }
         this._helperVector1.length = 0;
         this._helperVector2.length = 0;
      }
      
      protected function layoutVector(param1:Vector.<DisplayObject>, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc11_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc7_:* = null;
         var _loc8_:Boolean = false;
         param2.length = 0;
         var _loc13_:int = param1.length;
         var _loc12_:int = 0;
         _loc11_ = 0;
         while(_loc11_ < _loc13_)
         {
            _loc9_ = param1[_loc11_];
            _loc10_ = _loc9_ as ILayoutDisplayObject;
            if(!(!_loc10_ || !_loc10_.includeInLayout))
            {
               _loc7_ = _loc10_.layoutData as AnchorLayoutData;
               if(_loc7_)
               {
                  _loc8_ = this.isReadyForLayout(_loc7_,_loc11_,param1,param2);
                  if(!_loc8_)
                  {
                     param2[_loc12_] = _loc9_;
                     _loc12_++;
                  }
                  else
                  {
                     this.positionHorizontally(_loc10_,_loc7_,param3,param4,param5,param6);
                     this.positionVertically(_loc10_,_loc7_,param3,param4,param5,param6);
                  }
               }
            }
            _loc11_++;
         }
      }
      
      protected function positionHorizontally(param1:ILayoutDisplayObject, param2:AnchorLayoutData, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc15_:* = NaN;
         var _loc19_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc13_:* = null;
         var _loc24_:* = null;
         var _loc18_:* = NaN;
         var _loc10_:* = null;
         var _loc25_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc12_:IFeathersControl = param1 as IFeathersControl;
         var _loc8_:* = Number(param2.percentWidth);
         var _loc23_:Boolean = false;
         if(_loc8_ === _loc8_)
         {
            if(_loc8_ > 100)
            {
               _loc8_ = 100;
            }
            _loc15_ = Number(_loc8_ * 0.01 * param5);
            if(_loc12_)
            {
               _loc19_ = _loc12_.minWidth;
               _loc17_ = _loc12_.maxWidth;
               if(_loc15_ < _loc19_)
               {
                  _loc15_ = _loc19_;
               }
               else if(_loc15_ > _loc17_)
               {
                  _loc15_ = _loc17_;
               }
            }
            param1.width = _loc15_;
            _loc23_ = true;
         }
         var _loc21_:Number = param2.left;
         var _loc22_:* = _loc21_ === _loc21_;
         if(_loc22_)
         {
            _loc13_ = param2.leftAnchorDisplayObject;
            if(_loc13_)
            {
               param1.x = param1.pivotX + _loc13_.x - _loc13_.pivotX + _loc13_.width + _loc21_;
            }
            else
            {
               param1.x = param1.pivotX + param3 + _loc21_;
            }
         }
         var _loc7_:Number = param2.horizontalCenter;
         var _loc16_:* = _loc7_ === _loc7_;
         var _loc20_:Number = param2.right;
         var _loc9_:* = _loc20_ === _loc20_;
         if(_loc9_)
         {
            _loc24_ = param2.rightAnchorDisplayObject;
            if(_loc22_)
            {
               _loc18_ = param5;
               if(_loc24_)
               {
                  _loc18_ = Number(_loc24_.x - _loc24_.pivotX);
               }
               if(_loc13_)
               {
                  _loc18_ = Number(_loc18_ - (_loc13_.x - _loc13_.pivotX + _loc13_.width));
               }
               _loc23_ = false;
               param1.width = _loc18_ - _loc20_ - _loc21_;
            }
            else if(_loc16_)
            {
               _loc10_ = param2.horizontalCenterAnchorDisplayObject;
               if(_loc10_)
               {
                  _loc25_ = _loc10_.x - _loc10_.pivotX + Math.round(_loc10_.width / 2) + _loc7_;
               }
               else
               {
                  _loc25_ = Math.round(param5 / 2) + _loc7_;
               }
               if(_loc24_)
               {
                  _loc11_ = _loc24_.x - _loc24_.pivotX - _loc20_;
               }
               else
               {
                  _loc11_ = param5 - _loc20_;
               }
               _loc23_ = false;
               param1.width = 2 * (_loc11_ - _loc25_);
               param1.x = param1.pivotX + param5 - _loc20_ - param1.width;
            }
            else if(_loc24_)
            {
               param1.x = param1.pivotX + _loc24_.x - _loc24_.pivotX - param1.width - _loc20_;
            }
            else
            {
               param1.x = param1.pivotX + param3 + param5 - _loc20_ - param1.width;
            }
         }
         else if(_loc16_)
         {
            _loc10_ = param2.horizontalCenterAnchorDisplayObject;
            if(_loc10_)
            {
               _loc25_ = _loc10_.x - _loc10_.pivotX + Math.round(_loc10_.width / 2) + _loc7_;
            }
            else
            {
               _loc25_ = Math.round(param5 / 2) + _loc7_;
            }
            if(_loc22_)
            {
               _loc23_ = false;
               param1.width = 2 * (_loc25_ - param1.x + param1.pivotX);
            }
            else
            {
               param1.x = param1.pivotX + _loc25_ - Math.round(param1.width / 2);
            }
         }
         if(_loc23_)
         {
            _loc14_ = param1.x;
            _loc15_ = Number(param1.width);
            if(_loc14_ + _loc15_ > param5)
            {
               _loc15_ = Number(param5 - _loc14_);
               if(_loc12_)
               {
                  if(_loc15_ < _loc19_)
                  {
                     _loc15_ = _loc19_;
                  }
               }
               param1.width = _loc15_;
            }
         }
      }
      
      protected function positionVertically(param1:ILayoutDisplayObject, param2:AnchorLayoutData, param3:Number, param4:Number, param5:Number, param6:Number) : void
      {
         var _loc7_:* = NaN;
         var _loc8_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc19_:* = null;
         var _loc23_:* = null;
         var _loc15_:* = NaN;
         var _loc24_:* = null;
         var _loc9_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc13_:IFeathersControl = param1 as IFeathersControl;
         var _loc10_:* = Number(param2.percentHeight);
         var _loc25_:Boolean = false;
         if(_loc10_ === _loc10_)
         {
            if(_loc10_ > 100)
            {
               _loc10_ = 100;
            }
            _loc7_ = Number(_loc10_ * 0.01 * param6);
            if(_loc13_)
            {
               _loc8_ = _loc13_.minHeight;
               _loc12_ = _loc13_.maxHeight;
               if(_loc7_ < _loc8_)
               {
                  _loc7_ = _loc8_;
               }
               else if(_loc7_ > _loc12_)
               {
                  _loc7_ = _loc12_;
               }
            }
            param1.height = _loc7_;
            _loc25_ = true;
         }
         var _loc11_:Number = param2.top;
         var _loc21_:* = _loc11_ === _loc11_;
         if(_loc21_)
         {
            _loc19_ = param2.topAnchorDisplayObject;
            if(_loc19_)
            {
               param1.y = param1.pivotY + _loc19_.y - _loc19_.pivotY + _loc19_.height + _loc11_;
            }
            else
            {
               param1.y = param1.pivotY + param4 + _loc11_;
            }
         }
         var _loc18_:Number = param2.verticalCenter;
         var _loc14_:* = _loc18_ === _loc18_;
         var _loc20_:Number = param2.bottom;
         var _loc22_:* = _loc20_ === _loc20_;
         if(_loc22_)
         {
            _loc23_ = param2.bottomAnchorDisplayObject;
            if(_loc21_)
            {
               _loc15_ = param6;
               if(_loc23_)
               {
                  _loc15_ = Number(_loc23_.y - _loc23_.pivotY);
               }
               if(_loc19_)
               {
                  _loc15_ = Number(_loc15_ - (_loc19_.y - _loc19_.pivotY + _loc19_.height));
               }
               _loc25_ = false;
               param1.height = _loc15_ - _loc20_ - _loc11_;
            }
            else if(_loc14_)
            {
               _loc24_ = param2.verticalCenterAnchorDisplayObject;
               if(_loc24_)
               {
                  _loc9_ = _loc24_.y - _loc24_.pivotY + Math.round(_loc24_.height / 2) + _loc18_;
               }
               else
               {
                  _loc9_ = Math.round(param6 / 2) + _loc18_;
               }
               if(_loc23_)
               {
                  _loc17_ = _loc23_.y - _loc23_.pivotY - _loc20_;
               }
               else
               {
                  _loc17_ = param6 - _loc20_;
               }
               _loc25_ = false;
               param1.height = 2 * (_loc17_ - _loc9_);
               param1.y = param1.pivotY + param6 - _loc20_ - param1.height;
            }
            else if(_loc23_)
            {
               param1.y = param1.pivotY + _loc23_.y - _loc23_.pivotY - param1.height - _loc20_;
            }
            else
            {
               param1.y = param1.pivotY + param4 + param6 - _loc20_ - param1.height;
            }
         }
         else if(_loc14_)
         {
            _loc24_ = param2.verticalCenterAnchorDisplayObject;
            if(_loc24_)
            {
               _loc9_ = _loc24_.y - _loc24_.pivotY + Math.round(_loc24_.height / 2) + _loc18_;
            }
            else
            {
               _loc9_ = Math.round(param6 / 2) + _loc18_;
            }
            if(_loc21_)
            {
               _loc25_ = false;
               param1.height = 2 * (_loc9_ - param1.y + param1.pivotY);
            }
            else
            {
               param1.y = param1.pivotY + _loc9_ - Math.round(param1.height / 2);
            }
         }
         if(_loc25_)
         {
            _loc16_ = param1.y;
            _loc7_ = Number(param1.height);
            if(_loc16_ + _loc7_ > param6)
            {
               _loc7_ = Number(param6 - _loc16_);
               if(_loc13_)
               {
                  if(_loc7_ < _loc8_)
                  {
                     _loc7_ = _loc8_;
                  }
               }
               param1.height = _loc7_;
            }
         }
      }
      
      protected function measureContent(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Point = null) : Point
      {
         var _loc9_:int = 0;
         var _loc5_:* = null;
         var _loc10_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:* = param2;
         var _loc7_:* = param3;
         var _loc11_:int = param1.length;
         _loc9_ = 0;
         while(_loc9_ < _loc11_)
         {
            _loc5_ = param1[_loc9_];
            _loc10_ = _loc5_.x - _loc5_.pivotX + _loc5_.width;
            _loc6_ = _loc5_.y - _loc5_.pivotY + _loc5_.height;
            if(_loc10_ === _loc10_ && _loc10_ > _loc8_)
            {
               _loc8_ = _loc10_;
            }
            if(_loc6_ === _loc6_ && _loc6_ > _loc7_)
            {
               _loc7_ = _loc6_;
            }
            _loc9_++;
         }
         param4.x = _loc8_;
         param4.y = _loc7_;
         return param4;
      }
      
      protected function isReadyForLayout(param1:AnchorLayoutData, param2:int, param3:Vector.<DisplayObject>, param4:Vector.<DisplayObject>) : Boolean
      {
         var _loc8_:int = param2 + 1;
         var _loc7_:DisplayObject = param1.leftAnchorDisplayObject;
         if(_loc7_ && (param3.indexOf(_loc7_,_loc8_) >= _loc8_ || param4.indexOf(_loc7_) >= 0))
         {
            return false;
         }
         var _loc9_:DisplayObject = param1.rightAnchorDisplayObject;
         if(_loc9_ && (param3.indexOf(_loc9_,_loc8_) >= _loc8_ || param4.indexOf(_loc9_) >= 0))
         {
            return false;
         }
         var _loc5_:DisplayObject = param1.topAnchorDisplayObject;
         if(_loc5_ && (param3.indexOf(_loc5_,_loc8_) >= _loc8_ || param4.indexOf(_loc5_) >= 0))
         {
            return false;
         }
         var _loc6_:DisplayObject = param1.bottomAnchorDisplayObject;
         if(_loc6_ && (param3.indexOf(_loc6_,_loc8_) >= _loc8_ || param4.indexOf(_loc6_) >= 0))
         {
            return false;
         }
         return true;
      }
      
      protected function isReferenced(param1:DisplayObject, param2:Vector.<DisplayObject>) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = param2.length;
         _loc4_ = 0;
         while(_loc4_ < _loc6_)
         {
            _loc5_ = param2[_loc4_] as ILayoutDisplayObject;
            if(!(!_loc5_ || param2[_loc4_] == param1))
            {
               _loc3_ = _loc5_.layoutData as AnchorLayoutData;
               if(_loc3_)
               {
                  if(_loc3_.leftAnchorDisplayObject == param1 || _loc3_.horizontalCenterAnchorDisplayObject == param1 || _loc3_.rightAnchorDisplayObject == param1 || _loc3_.topAnchorDisplayObject == param1 || _loc3_.verticalCenterAnchorDisplayObject == param1 || _loc3_.bottomAnchorDisplayObject == param1)
                  {
                     return true;
                  }
               }
            }
            _loc4_++;
         }
         return false;
      }
      
      protected function validateItems(param1:Vector.<DisplayObject>, param2:Boolean) : void
      {
         var _loc7_:int = 0;
         var _loc8_:* = null;
         var _loc16_:* = null;
         var _loc3_:* = null;
         var _loc15_:Number = NaN;
         var _loc18_:* = false;
         var _loc9_:Number = NaN;
         var _loc11_:* = false;
         var _loc10_:Number = NaN;
         var _loc19_:* = false;
         var _loc14_:Number = NaN;
         var _loc6_:* = false;
         var _loc5_:Number = NaN;
         var _loc13_:* = false;
         var _loc4_:Number = NaN;
         var _loc17_:* = false;
         var _loc12_:int = param1.length;
         _loc7_ = 0;
         for(; _loc7_ < _loc12_; _loc7_++)
         {
            _loc8_ = param1[_loc7_] as IFeathersControl;
            if(_loc8_)
            {
               if(param2)
               {
                  _loc8_.validate();
               }
               else
               {
                  if(_loc8_ is ILayoutDisplayObject)
                  {
                     _loc16_ = ILayoutDisplayObject(_loc8_);
                     if(_loc16_.includeInLayout)
                     {
                        _loc3_ = _loc16_.layoutData as AnchorLayoutData;
                        if(_loc3_)
                        {
                           _loc15_ = _loc3_.left;
                           _loc18_ = _loc15_ === _loc15_;
                           _loc9_ = _loc3_.right;
                           _loc11_ = _loc9_ === _loc9_;
                           _loc10_ = _loc3_.horizontalCenter;
                           _loc19_ = _loc10_ === _loc10_;
                           if(_loc11_ && !_loc18_ && !_loc19_ || _loc19_)
                           {
                              _loc8_.validate();
                              continue;
                           }
                           _loc14_ = _loc3_.top;
                           _loc6_ = _loc14_ === _loc14_;
                           _loc5_ = _loc3_.bottom;
                           _loc13_ = _loc5_ === _loc5_;
                           _loc4_ = _loc3_.verticalCenter;
                           _loc17_ = _loc4_ === _loc4_;
                           if(_loc13_ && !_loc6_ && !_loc17_ || _loc17_)
                           {
                              _loc8_.validate();
                              continue;
                           }
                        }
                     }
                     continue;
                  }
                  if(this.isReferenced(DisplayObject(_loc8_),param1))
                  {
                     _loc8_.validate();
                     continue;
                  }
               }
               continue;
            }
         }
      }
   }
}
