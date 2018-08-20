package feathers.layout
{
   import starling.display.DisplayObject;
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class AnchorLayoutData extends EventDispatcher implements ILayoutData
   {
       
      
      protected var _percentWidth:Number = NaN;
      
      protected var _percentHeight:Number = NaN;
      
      protected var _topAnchorDisplayObject:DisplayObject;
      
      protected var _top:Number = NaN;
      
      protected var _rightAnchorDisplayObject:DisplayObject;
      
      protected var _right:Number = NaN;
      
      protected var _bottomAnchorDisplayObject:DisplayObject;
      
      protected var _bottom:Number = NaN;
      
      protected var _leftAnchorDisplayObject:DisplayObject;
      
      protected var _left:Number = NaN;
      
      protected var _horizontalCenterAnchorDisplayObject:DisplayObject;
      
      protected var _horizontalCenter:Number = NaN;
      
      protected var _verticalCenterAnchorDisplayObject:DisplayObject;
      
      protected var _verticalCenter:Number = NaN;
      
      public function AnchorLayoutData(param1:Number = NaN, param2:Number = NaN, param3:Number = NaN, param4:Number = NaN, param5:Number = NaN, param6:Number = NaN)
      {
         super();
         this.top = param1;
         this.right = param2;
         this.bottom = param3;
         this.left = param4;
         this.horizontalCenter = param5;
         this.verticalCenter = param6;
      }
      
      public function get percentWidth() : Number
      {
         return this._percentWidth;
      }
      
      public function set percentWidth(param1:Number) : void
      {
         if(this._percentWidth == param1)
         {
            return;
         }
         this._percentWidth = param1;
         this.dispatchEventWith("change");
      }
      
      public function get percentHeight() : Number
      {
         return this._percentHeight;
      }
      
      public function set percentHeight(param1:Number) : void
      {
         if(this._percentHeight == param1)
         {
            return;
         }
         this._percentHeight = param1;
         this.dispatchEventWith("change");
      }
      
      public function get topAnchorDisplayObject() : DisplayObject
      {
         return this._topAnchorDisplayObject;
      }
      
      public function set topAnchorDisplayObject(param1:DisplayObject) : void
      {
         if(this._topAnchorDisplayObject == param1)
         {
            return;
         }
         this._topAnchorDisplayObject = param1;
         this.dispatchEventWith("change");
      }
      
      public function get top() : Number
      {
         return this._top;
      }
      
      public function set top(param1:Number) : void
      {
         if(this._top == param1)
         {
            return;
         }
         this._top = param1;
         this.dispatchEventWith("change");
      }
      
      public function get rightAnchorDisplayObject() : DisplayObject
      {
         return this._rightAnchorDisplayObject;
      }
      
      public function set rightAnchorDisplayObject(param1:DisplayObject) : void
      {
         if(this._rightAnchorDisplayObject == param1)
         {
            return;
         }
         this._rightAnchorDisplayObject = param1;
         this.dispatchEventWith("change");
      }
      
      public function get right() : Number
      {
         return this._right;
      }
      
      public function set right(param1:Number) : void
      {
         if(this._right == param1)
         {
            return;
         }
         this._right = param1;
         this.dispatchEventWith("change");
      }
      
      public function get bottomAnchorDisplayObject() : DisplayObject
      {
         return this._bottomAnchorDisplayObject;
      }
      
      public function set bottomAnchorDisplayObject(param1:DisplayObject) : void
      {
         if(this._bottomAnchorDisplayObject == param1)
         {
            return;
         }
         this._bottomAnchorDisplayObject = param1;
         this.dispatchEventWith("change");
      }
      
      public function get bottom() : Number
      {
         return this._bottom;
      }
      
      public function set bottom(param1:Number) : void
      {
         if(this._bottom == param1)
         {
            return;
         }
         this._bottom = param1;
         this.dispatchEventWith("change");
      }
      
      public function get leftAnchorDisplayObject() : DisplayObject
      {
         return this._leftAnchorDisplayObject;
      }
      
      public function set leftAnchorDisplayObject(param1:DisplayObject) : void
      {
         if(this._leftAnchorDisplayObject == param1)
         {
            return;
         }
         this._leftAnchorDisplayObject = param1;
         this.dispatchEventWith("change");
      }
      
      public function get left() : Number
      {
         return this._left;
      }
      
      public function set left(param1:Number) : void
      {
         if(this._left == param1)
         {
            return;
         }
         this._left = param1;
         this.dispatchEventWith("change");
      }
      
      public function get horizontalCenterAnchorDisplayObject() : DisplayObject
      {
         return this._horizontalCenterAnchorDisplayObject;
      }
      
      public function set horizontalCenterAnchorDisplayObject(param1:DisplayObject) : void
      {
         if(this._horizontalCenterAnchorDisplayObject == param1)
         {
            return;
         }
         this._horizontalCenterAnchorDisplayObject = param1;
         this.dispatchEventWith("change");
      }
      
      public function get horizontalCenter() : Number
      {
         return this._horizontalCenter;
      }
      
      public function set horizontalCenter(param1:Number) : void
      {
         if(this._horizontalCenter == param1)
         {
            return;
         }
         this._horizontalCenter = param1;
         this.dispatchEventWith("change");
      }
      
      public function get verticalCenterAnchorDisplayObject() : DisplayObject
      {
         return this._verticalCenterAnchorDisplayObject;
      }
      
      public function set verticalCenterAnchorDisplayObject(param1:DisplayObject) : void
      {
         if(this._verticalCenterAnchorDisplayObject == param1)
         {
            return;
         }
         this._verticalCenterAnchorDisplayObject = param1;
         this.dispatchEventWith("change");
      }
      
      public function get verticalCenter() : Number
      {
         return this._verticalCenter;
      }
      
      public function set verticalCenter(param1:Number) : void
      {
         if(this._verticalCenter == param1)
         {
            return;
         }
         this._verticalCenter = param1;
         this.dispatchEventWith("change");
      }
   }
}
