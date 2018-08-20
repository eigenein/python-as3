package feathers.layout
{
   import feathers.core.IValidating;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class TiledRowsLayout extends EventDispatcher implements IVirtualLayout
   {
      
      public static const VERTICAL_ALIGN_TOP:String = "top";
      
      public static const VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const HORIZONTAL_ALIGN_RIGHT:String = "right";
      
      public static const TILE_VERTICAL_ALIGN_TOP:String = "top";
      
      public static const TILE_VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const TILE_VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const TILE_VERTICAL_ALIGN_JUSTIFY:String = "justify";
      
      public static const TILE_HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const TILE_HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const TILE_HORIZONTAL_ALIGN_RIGHT:String = "right";
      
      public static const TILE_HORIZONTAL_ALIGN_JUSTIFY:String = "justify";
      
      public static const PAGING_HORIZONTAL:String = "horizontal";
      
      public static const PAGING_VERTICAL:String = "vertical";
      
      public static const PAGING_NONE:String = "none";
       
      
      protected var _discoveredItemsCache:Vector.<DisplayObject>;
      
      protected var _horizontalGap:Number = 0;
      
      protected var _verticalGap:Number = 0;
      
      protected var _paddingTop:Number = 0;
      
      protected var _paddingRight:Number = 0;
      
      protected var _paddingBottom:Number = 0;
      
      protected var _paddingLeft:Number = 0;
      
      protected var _requestedColumnCount:int = 0;
      
      protected var _requestedRowCount:int = 0;
      
      protected var _verticalAlign:String = "top";
      
      protected var _horizontalAlign:String = "center";
      
      protected var _tileVerticalAlign:String = "middle";
      
      protected var _tileHorizontalAlign:String = "center";
      
      protected var _paging:String = "none";
      
      protected var _useSquareTiles:Boolean = true;
      
      protected var _manageVisibility:Boolean = false;
      
      protected var _useVirtualLayout:Boolean = true;
      
      protected var _typicalItem:DisplayObject;
      
      protected var _resetTypicalItemDimensionsOnMeasure:Boolean = false;
      
      protected var _typicalItemWidth:Number = NaN;
      
      protected var _typicalItemHeight:Number = NaN;
      
      public function TiledRowsLayout()
      {
         _discoveredItemsCache = new Vector.<DisplayObject>(0);
         super();
      }
      
      public function get gap() : Number
      {
         return this._horizontalGap;
      }
      
      public function set gap(param1:Number) : void
      {
         this.horizontalGap = param1;
         this.verticalGap = param1;
      }
      
      public function get horizontalGap() : Number
      {
         return this._horizontalGap;
      }
      
      public function set horizontalGap(param1:Number) : void
      {
         if(this._horizontalGap == param1)
         {
            return;
         }
         this._horizontalGap = param1;
         this.dispatchEventWith("change");
      }
      
      public function get verticalGap() : Number
      {
         return this._verticalGap;
      }
      
      public function set verticalGap(param1:Number) : void
      {
         if(this._verticalGap == param1)
         {
            return;
         }
         this._verticalGap = param1;
         this.dispatchEventWith("change");
      }
      
      public function get padding() : Number
      {
         return this._paddingTop;
      }
      
      public function set padding(param1:Number) : void
      {
         this.paddingTop = param1;
         this.paddingRight = param1;
         this.paddingBottom = param1;
         this.paddingLeft = param1;
      }
      
      public function get paddingTop() : Number
      {
         return this._paddingTop;
      }
      
      public function set paddingTop(param1:Number) : void
      {
         if(this._paddingTop == param1)
         {
            return;
         }
         this._paddingTop = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paddingRight() : Number
      {
         return this._paddingRight;
      }
      
      public function set paddingRight(param1:Number) : void
      {
         if(this._paddingRight == param1)
         {
            return;
         }
         this._paddingRight = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paddingBottom() : Number
      {
         return this._paddingBottom;
      }
      
      public function set paddingBottom(param1:Number) : void
      {
         if(this._paddingBottom == param1)
         {
            return;
         }
         this._paddingBottom = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paddingLeft() : Number
      {
         return this._paddingLeft;
      }
      
      public function set paddingLeft(param1:Number) : void
      {
         if(this._paddingLeft == param1)
         {
            return;
         }
         this._paddingLeft = param1;
         this.dispatchEventWith("change");
      }
      
      public function get requestedColumnCount() : int
      {
         return this._requestedColumnCount;
      }
      
      public function set requestedColumnCount(param1:int) : void
      {
         if(param1 < 0)
         {
            throw RangeError("requestedColumnCount requires a value >= 0");
         }
         if(this._requestedColumnCount == param1)
         {
            return;
         }
         this._requestedColumnCount = param1;
         this.dispatchEventWith("change");
      }
      
      public function get requestedRowCount() : int
      {
         return this._requestedRowCount;
      }
      
      public function set requestedRowCount(param1:int) : void
      {
         if(param1 < 0)
         {
            throw RangeError("requestedRowCount requires a value >= 0");
         }
         if(this._requestedRowCount == param1)
         {
            return;
         }
         this._requestedRowCount = param1;
         this.dispatchEventWith("change");
      }
      
      [Inspectable(type="String",enumeration="top,middle,bottom")]
      public function get verticalAlign() : String
      {
         return this._verticalAlign;
      }
      
      public function set verticalAlign(param1:String) : void
      {
         if(this._verticalAlign == param1)
         {
            return;
         }
         this._verticalAlign = param1;
         this.dispatchEventWith("change");
      }
      
      [Inspectable(type="String",enumeration="left,center,right")]
      public function get horizontalAlign() : String
      {
         return this._horizontalAlign;
      }
      
      public function set horizontalAlign(param1:String) : void
      {
         if(this._horizontalAlign == param1)
         {
            return;
         }
         this._horizontalAlign = param1;
         this.dispatchEventWith("change");
      }
      
      [Inspectable(type="String",enumeration="top,middle,bottom,justify")]
      public function get tileVerticalAlign() : String
      {
         return this._tileVerticalAlign;
      }
      
      public function set tileVerticalAlign(param1:String) : void
      {
         if(this._tileVerticalAlign == param1)
         {
            return;
         }
         this._tileVerticalAlign = param1;
         this.dispatchEventWith("change");
      }
      
      [Inspectable(type="String",enumeration="left,center,right,justify")]
      public function get tileHorizontalAlign() : String
      {
         return this._tileHorizontalAlign;
      }
      
      public function set tileHorizontalAlign(param1:String) : void
      {
         if(this._tileHorizontalAlign == param1)
         {
            return;
         }
         this._tileHorizontalAlign = param1;
         this.dispatchEventWith("change");
      }
      
      public function get paging() : String
      {
         return this._paging;
      }
      
      public function set paging(param1:String) : void
      {
         if(this._paging == param1)
         {
            return;
         }
         this._paging = param1;
         this.dispatchEventWith("change");
      }
      
      public function get useSquareTiles() : Boolean
      {
         return this._useSquareTiles;
      }
      
      public function set useSquareTiles(param1:Boolean) : void
      {
         if(this._useSquareTiles == param1)
         {
            return;
         }
         this._useSquareTiles = param1;
         this.dispatchEventWith("change");
      }
      
      public function get manageVisibility() : Boolean
      {
         return this._manageVisibility;
      }
      
      public function set manageVisibility(param1:Boolean) : void
      {
         if(this._manageVisibility == param1)
         {
            return;
         }
         this._manageVisibility = param1;
         this.dispatchEventWith("change");
      }
      
      public function get useVirtualLayout() : Boolean
      {
         return this._useVirtualLayout;
      }
      
      public function set useVirtualLayout(param1:Boolean) : void
      {
         if(this._useVirtualLayout == param1)
         {
            return;
         }
         this._useVirtualLayout = param1;
         this.dispatchEventWith("change");
      }
      
      public function get typicalItem() : DisplayObject
      {
         return this._typicalItem;
      }
      
      public function set typicalItem(param1:DisplayObject) : void
      {
         if(this._typicalItem == param1)
         {
            return;
         }
         this._typicalItem = param1;
         this.dispatchEventWith("change");
      }
      
      public function get resetTypicalItemDimensionsOnMeasure() : Boolean
      {
         return this._resetTypicalItemDimensionsOnMeasure;
      }
      
      public function set resetTypicalItemDimensionsOnMeasure(param1:Boolean) : void
      {
         if(this._resetTypicalItemDimensionsOnMeasure == param1)
         {
            return;
         }
         this._resetTypicalItemDimensionsOnMeasure = param1;
         this.dispatchEventWith("change");
      }
      
      public function get typicalItemWidth() : Number
      {
         return this._typicalItemWidth;
      }
      
      public function set typicalItemWidth(param1:Number) : void
      {
         if(this._typicalItemWidth == param1)
         {
            return;
         }
         this._typicalItemWidth = param1;
         this.dispatchEventWith("change");
      }
      
      public function get typicalItemHeight() : Number
      {
         return this._typicalItemHeight;
      }
      
      public function set typicalItemHeight(param1:Number) : void
      {
         if(this._typicalItemHeight == param1)
         {
            return;
         }
         this._typicalItemHeight = param1;
         this.dispatchEventWith("change");
      }
      
      public function get requiresLayoutOnScroll() : Boolean
      {
         return this._manageVisibility || this._useVirtualLayout;
      }
      
      public function layout(param1:Vector.<DisplayObject>, param2:ViewPortBounds = null, param3:LayoutBoundsResult = null) : LayoutBoundsResult
      {
         var _loc30_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:int = 0;
         var _loc22_:* = null;
         var _loc18_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc38_:* = 0;
         var _loc42_:int = 0;
         var _loc23_:* = undefined;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         if(!param3)
         {
            param3 = new LayoutBoundsResult();
         }
         if(param1.length == 0)
         {
            param3.contentX = 0;
            param3.contentY = 0;
            param3.contentWidth = 0;
            param3.contentHeight = 0;
            param3.viewPortWidth = 0;
            param3.viewPortHeight = 0;
            return param3;
         }
         var _loc44_:Number = !!param2?param2.scrollX:0;
         var _loc39_:Number = !!param2?param2.scrollY:0;
         var _loc34_:Number = !!param2?param2.x:0;
         var _loc36_:Number = !!param2?param2.y:0;
         var _loc28_:Number = !!param2?param2.minWidth:0;
         var _loc12_:Number = !!param2?param2.minHeight:0;
         var _loc20_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc14_:Number = !!param2?param2.maxHeight:Infinity;
         var _loc33_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc40_:Number = !!param2?param2.explicitHeight:NaN;
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem();
            _loc30_ = !!this._typicalItem?this._typicalItem.width:0;
            _loc26_ = !!this._typicalItem?this._typicalItem.height:0;
         }
         this.validateItems(param1);
         this._discoveredItemsCache.length = 0;
         var _loc31_:int = param1.length;
         var _loc29_:* = Number(!!this._useVirtualLayout?_loc30_:0);
         var _loc45_:* = Number(!!this._useVirtualLayout?_loc26_:0);
         if(!this._useVirtualLayout)
         {
            _loc27_ = 0;
            while(_loc27_ < _loc31_)
            {
               _loc22_ = param1[_loc27_];
               if(_loc22_)
               {
                  if(!(_loc22_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc22_).includeInLayout))
                  {
                     _loc18_ = _loc22_.width;
                     _loc8_ = _loc22_.height;
                     if(_loc18_ > _loc29_)
                     {
                        _loc29_ = _loc18_;
                     }
                     if(_loc8_ > _loc45_)
                     {
                        _loc45_ = _loc8_;
                     }
                  }
               }
               _loc27_++;
            }
         }
         if(_loc29_ < 0)
         {
            _loc29_ = 0;
         }
         if(_loc45_ < 0)
         {
            _loc45_ = 0;
         }
         if(this._useSquareTiles)
         {
            if(_loc29_ > _loc45_)
            {
               _loc45_ = _loc29_;
            }
            else if(_loc45_ > _loc29_)
            {
               _loc29_ = _loc45_;
            }
         }
         var _loc24_:* = NaN;
         var _loc6_:* = NaN;
         if(_loc33_ === _loc33_)
         {
            _loc24_ = _loc33_;
            _loc38_ = int((_loc33_ - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc29_ + this._horizontalGap));
         }
         else if(_loc20_ === _loc20_ && _loc20_ < Infinity)
         {
            _loc24_ = _loc20_;
            _loc38_ = int((_loc20_ - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc29_ + this._horizontalGap));
         }
         else
         {
            _loc38_ = _loc31_;
         }
         if(_loc38_ < 1)
         {
            _loc38_ = 1;
         }
         else if(this._requestedColumnCount > 0)
         {
            if(_loc24_ !== _loc24_)
            {
               _loc38_ = int(this._requestedColumnCount);
               _loc24_ = Number(_loc38_ * (_loc29_ + this._horizontalGap) - this._horizontalGap - this._paddingLeft - this._paddingRight);
            }
            else if(_loc38_ > this._requestedColumnCount)
            {
               _loc38_ = int(this._requestedColumnCount);
            }
         }
         if(_loc40_ === _loc40_)
         {
            _loc6_ = _loc40_;
            _loc42_ = (_loc40_ - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc45_ + this._verticalGap);
         }
         else if(_loc14_ === _loc14_ && _loc14_ < Infinity)
         {
            _loc6_ = _loc14_;
            _loc42_ = (_loc14_ - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc45_ + this._verticalGap);
         }
         else
         {
            _loc42_ = Math.ceil(_loc31_ / _loc38_);
         }
         if(_loc42_ < 1)
         {
            _loc42_ = 1;
         }
         else if(this._requestedRowCount > 0)
         {
            if(_loc6_ !== _loc6_)
            {
               _loc42_ = this._requestedRowCount;
               _loc6_ = Number(_loc42_ * (_loc45_ + this._verticalGap) - this._verticalGap - this._paddingTop - this._paddingBottom);
            }
            else if(_loc42_ > this._requestedRowCount)
            {
               _loc42_ = this._requestedRowCount;
            }
         }
         var _loc10_:Number = _loc38_ * (_loc29_ + this._horizontalGap) - this._horizontalGap + this._paddingLeft + this._paddingRight;
         var _loc16_:Number = _loc42_ * (_loc45_ + this._verticalGap) - this._verticalGap + this._paddingTop + this._paddingBottom;
         var _loc4_:* = _loc24_;
         if(_loc4_ !== _loc4_)
         {
            _loc4_ = _loc10_;
         }
         var _loc25_:* = _loc6_;
         if(_loc25_ !== _loc25_)
         {
            _loc25_ = _loc16_;
         }
         var _loc43_:Number = _loc34_ + this._paddingLeft;
         var _loc41_:Number = _loc36_ + this._paddingTop;
         var _loc35_:int = _loc38_ * _loc42_;
         var _loc37_:int = 0;
         var _loc32_:* = _loc35_;
         var _loc15_:* = _loc43_;
         var _loc11_:* = _loc43_;
         var _loc13_:* = _loc41_;
         var _loc17_:int = 0;
         var _loc21_:int = 0;
         _loc27_ = 0;
         while(_loc27_ < _loc31_)
         {
            _loc22_ = param1[_loc27_];
            if(!(_loc22_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc22_).includeInLayout))
            {
               if(_loc17_ != 0 && _loc17_ % _loc38_ == 0)
               {
                  _loc11_ = _loc15_;
                  _loc13_ = Number(_loc13_ + (_loc45_ + this._verticalGap));
               }
               if(_loc17_ == _loc32_)
               {
                  if(this._paging != "none")
                  {
                     _loc23_ = !!this._useVirtualLayout?this._discoveredItemsCache:param1;
                     _loc7_ = !!this._useVirtualLayout?0:Number(_loc17_ - _loc35_);
                     _loc9_ = !!this._useVirtualLayout?this._discoveredItemsCache.length - 1:Number(_loc17_ - 1);
                     this.applyHorizontalAlign(_loc23_,_loc7_,_loc9_,_loc10_,_loc4_);
                     this.applyVerticalAlign(_loc23_,_loc7_,_loc9_,_loc16_,_loc25_);
                     if(this.manageVisibility)
                     {
                        this.applyVisible(_loc23_,_loc7_,_loc9_,_loc34_ + _loc44_,_loc44_ + _loc24_,_loc36_ + _loc39_,_loc39_ + _loc6_);
                     }
                     this._discoveredItemsCache.length = 0;
                     _loc21_ = 0;
                  }
                  _loc37_++;
                  _loc32_ = int(_loc32_ + _loc35_);
                  if(this._paging == "horizontal")
                  {
                     _loc15_ = Number(_loc43_ + _loc24_ * _loc37_);
                     _loc11_ = Number(_loc43_ + _loc24_ * _loc37_);
                     _loc13_ = _loc41_;
                  }
                  else if(this._paging == "vertical")
                  {
                     _loc13_ = Number(_loc41_ + _loc6_ * _loc37_);
                  }
               }
               if(_loc22_)
               {
                  var _loc46_:* = this._tileHorizontalAlign;
                  if("justify" !== _loc46_)
                  {
                     if("left" !== _loc46_)
                     {
                        if("right" !== _loc46_)
                        {
                           _loc22_.x = _loc22_.pivotX + _loc11_ + Math.round((_loc29_ - _loc22_.width) / 2);
                        }
                        else
                        {
                           _loc22_.x = _loc22_.pivotX + _loc11_ + _loc29_ - _loc22_.width;
                        }
                     }
                     else
                     {
                        _loc22_.x = _loc22_.pivotX + _loc11_;
                     }
                  }
                  else
                  {
                     _loc22_.x = _loc22_.pivotX + _loc11_;
                     _loc22_.width = _loc29_;
                  }
                  _loc46_ = this._tileVerticalAlign;
                  if("justify" !== _loc46_)
                  {
                     if("top" !== _loc46_)
                     {
                        if("bottom" !== _loc46_)
                        {
                           _loc22_.y = _loc22_.pivotY + _loc13_ + Math.round((_loc45_ - _loc22_.height) / 2);
                        }
                        else
                        {
                           _loc22_.y = _loc22_.pivotY + _loc13_ + _loc45_ - _loc22_.height;
                        }
                     }
                     else
                     {
                        _loc22_.y = _loc22_.pivotY + _loc13_;
                     }
                  }
                  else
                  {
                     _loc22_.y = _loc22_.pivotY + _loc13_;
                     _loc22_.height = _loc45_;
                  }
                  if(this._useVirtualLayout)
                  {
                     this._discoveredItemsCache[_loc21_] = _loc22_;
                     _loc21_++;
                  }
               }
               _loc11_ = Number(_loc11_ + (_loc29_ + this._horizontalGap));
               _loc17_++;
            }
            _loc27_++;
         }
         if(this._paging != "none")
         {
            _loc23_ = !!this._useVirtualLayout?this._discoveredItemsCache:param1;
            _loc7_ = !!this._useVirtualLayout?0:Number(_loc32_ - _loc35_);
            _loc9_ = !!this._useVirtualLayout?_loc23_.length - 1:Number(_loc27_ - 1);
            this.applyHorizontalAlign(_loc23_,_loc7_,_loc9_,_loc10_,_loc4_);
            this.applyVerticalAlign(_loc23_,_loc7_,_loc9_,_loc16_,_loc25_);
            if(this.manageVisibility)
            {
               this.applyVisible(_loc23_,_loc7_,_loc9_,_loc34_ + _loc44_,_loc44_ + _loc24_,_loc36_ + _loc39_,_loc39_ + _loc6_);
            }
         }
         var _loc19_:* = _loc10_;
         if(_loc24_ === _loc24_ && this._paging == "horizontal")
         {
            _loc19_ = Number(Math.ceil(_loc31_ / _loc35_) * _loc24_);
         }
         var _loc5_:* = Number(_loc13_ + _loc45_ + this._paddingBottom);
         if(_loc6_ === _loc6_)
         {
            if(this._paging == "horizontal")
            {
               _loc5_ = _loc6_;
            }
            else if(this._paging == "vertical")
            {
               _loc5_ = Number(Math.ceil(_loc31_ / _loc35_) * _loc6_);
            }
         }
         if(_loc24_ !== _loc24_)
         {
            _loc24_ = _loc19_;
         }
         if(_loc6_ !== _loc6_)
         {
            _loc6_ = _loc5_;
         }
         if(_loc24_ < _loc28_)
         {
            _loc24_ = _loc28_;
         }
         if(_loc6_ < _loc12_)
         {
            _loc6_ = _loc12_;
         }
         if(this._paging == "none")
         {
            _loc23_ = !!this._useVirtualLayout?this._discoveredItemsCache:param1;
            _loc9_ = _loc23_.length - 1;
            this.applyHorizontalAlign(_loc23_,0,_loc9_,_loc19_,_loc24_);
            this.applyVerticalAlign(_loc23_,0,_loc9_,_loc5_,_loc6_);
            if(this.manageVisibility)
            {
               this.applyVisible(_loc23_,_loc7_,_loc9_,_loc34_ + _loc44_,_loc44_ + _loc24_,_loc36_ + _loc39_,_loc39_ + _loc6_);
            }
         }
         this._discoveredItemsCache.length = 0;
         param3.contentX = 0;
         param3.contentY = 0;
         param3.contentWidth = _loc19_;
         param3.contentHeight = _loc5_;
         param3.viewPortWidth = _loc24_;
         param3.viewPortHeight = _loc6_;
         return param3;
      }
      
      public function measureViewPort(param1:int, param2:ViewPortBounds = null, param3:Point = null) : Point
      {
         var _loc29_:* = 0;
         var _loc33_:int = 0;
         var _loc18_:int = 0;
         var _loc24_:* = NaN;
         var _loc30_:* = NaN;
         if(!param3)
         {
            param3 = new Point();
         }
         if(!this._useVirtualLayout)
         {
            throw new IllegalOperationError("measureViewPort() may be called only if useVirtualLayout is true.");
         }
         var _loc23_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc31_:Number = !!param2?param2.explicitHeight:NaN;
         var _loc16_:* = _loc23_ !== _loc23_;
         var _loc12_:* = _loc31_ !== _loc31_;
         if(!_loc16_ && !_loc12_)
         {
            param3.x = _loc23_;
            param3.y = _loc31_;
            return param3;
         }
         var _loc25_:Number = !!param2?param2.x:0;
         var _loc27_:Number = !!param2?param2.y:0;
         var _loc19_:Number = !!param2?param2.minWidth:0;
         var _loc8_:Number = !!param2?param2.minHeight:0;
         var _loc14_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc10_:Number = !!param2?param2.maxHeight:Infinity;
         this.prepareTypicalItem();
         var _loc21_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc17_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc20_:* = _loc21_;
         var _loc35_:* = _loc17_;
         if(_loc20_ < 0)
         {
            _loc20_ = 0;
         }
         if(_loc35_ < 0)
         {
            _loc35_ = 0;
         }
         if(this._useSquareTiles)
         {
            if(_loc20_ > _loc35_)
            {
               _loc35_ = _loc20_;
            }
            else if(_loc35_ > _loc20_)
            {
               _loc20_ = _loc35_;
            }
         }
         var _loc15_:* = NaN;
         var _loc5_:* = NaN;
         if(_loc23_ === _loc23_)
         {
            _loc15_ = _loc23_;
            _loc29_ = int((_loc23_ - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc20_ + this._horizontalGap));
         }
         else if(_loc14_ === _loc14_ && _loc14_ < Infinity)
         {
            _loc15_ = _loc14_;
            _loc29_ = int((_loc14_ - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc20_ + this._horizontalGap));
         }
         else
         {
            _loc29_ = param1;
         }
         if(_loc29_ < 1)
         {
            _loc29_ = 1;
         }
         else if(this._requestedColumnCount > 0)
         {
            if(_loc15_ !== _loc15_)
            {
               _loc29_ = int(this._requestedColumnCount);
               _loc15_ = Number(_loc29_ * (_loc20_ + this._horizontalGap) - this._horizontalGap - this._paddingLeft - this._paddingRight);
            }
            else if(_loc29_ > this._requestedColumnCount)
            {
               _loc29_ = int(this._requestedColumnCount);
            }
         }
         if(_loc31_ === _loc31_)
         {
            _loc5_ = _loc31_;
            _loc33_ = (_loc31_ - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc35_ + this._verticalGap);
         }
         else if(_loc10_ === _loc10_ && _loc10_ < Infinity)
         {
            _loc5_ = _loc10_;
            _loc33_ = (_loc10_ - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc35_ + this._verticalGap);
         }
         else
         {
            _loc33_ = Math.ceil(param1 / _loc29_);
         }
         if(_loc33_ < 1)
         {
            _loc33_ = 1;
         }
         else if(this._requestedRowCount > 0)
         {
            if(_loc5_ !== _loc5_)
            {
               _loc33_ = this._requestedRowCount;
               _loc5_ = Number(_loc33_ * (_loc35_ + this._verticalGap) - this._verticalGap - this._paddingTop - this._paddingBottom);
            }
            else if(_loc33_ > this._requestedRowCount)
            {
               _loc33_ = this._requestedRowCount;
            }
         }
         var _loc6_:Number = _loc29_ * (_loc20_ + this._horizontalGap) - this._horizontalGap + this._paddingLeft + this._paddingRight;
         var _loc34_:Number = _loc25_ + this._paddingLeft;
         var _loc32_:Number = _loc27_ + this._paddingTop;
         var _loc26_:int = _loc29_ * _loc33_;
         var _loc28_:int = 0;
         var _loc22_:* = _loc26_;
         var _loc11_:* = _loc34_;
         var _loc7_:* = _loc34_;
         var _loc9_:* = _loc32_;
         _loc18_ = 0;
         while(_loc18_ < param1)
         {
            if(_loc18_ != 0 && _loc18_ % _loc29_ == 0)
            {
               _loc7_ = _loc11_;
               _loc9_ = Number(_loc9_ + (_loc35_ + this._verticalGap));
            }
            if(_loc18_ == _loc22_)
            {
               _loc28_++;
               _loc22_ = int(_loc22_ + _loc26_);
               if(this._paging == "horizontal")
               {
                  _loc11_ = Number(_loc34_ + _loc15_ * _loc28_);
                  _loc7_ = Number(_loc34_ + _loc15_ * _loc28_);
                  _loc9_ = _loc32_;
               }
               else if(this._paging == "vertical")
               {
                  _loc9_ = Number(_loc32_ + _loc5_ * _loc28_);
               }
            }
            _loc18_++;
         }
         var _loc13_:* = _loc6_;
         if(_loc15_ === _loc15_ && this._paging == "horizontal")
         {
            _loc13_ = Number(Math.ceil(param1 / _loc26_) * _loc15_);
         }
         var _loc4_:* = Number(_loc9_ + _loc35_ + this._paddingBottom);
         if(_loc5_ === _loc5_)
         {
            if(this._paging == "horizontal")
            {
               _loc4_ = _loc5_;
            }
            else if(this._paging == "vertical")
            {
               _loc4_ = Number(Math.ceil(param1 / _loc26_) * _loc5_);
            }
         }
         if(_loc16_)
         {
            _loc24_ = _loc13_;
            if(_loc24_ < _loc19_)
            {
               _loc24_ = _loc19_;
            }
            else if(_loc24_ > _loc14_)
            {
               _loc24_ = _loc14_;
            }
            param3.x = _loc24_;
         }
         else
         {
            param3.x = _loc23_;
         }
         if(_loc12_)
         {
            _loc30_ = _loc4_;
            if(_loc30_ < _loc8_)
            {
               _loc30_ = _loc8_;
            }
            else if(_loc30_ > _loc10_)
            {
               _loc30_ = _loc10_;
            }
            param3.y = _loc30_;
         }
         else
         {
            param3.y = _loc31_;
         }
         return param3;
      }
      
      public function getVisibleIndicesAtScrollPosition(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int> = null) : Vector.<int>
      {
         if(param6)
         {
            param6.length = 0;
         }
         else
         {
            param6 = new Vector.<int>(0);
         }
         if(!this._useVirtualLayout)
         {
            throw new IllegalOperationError("getVisibleIndicesAtScrollPosition() may be called only if useVirtualLayout is true.");
         }
         if(this._paging == "horizontal")
         {
            this.getVisibleIndicesAtScrollPositionWithHorizontalPaging(param1,param2,param3,param4,param5,param6);
         }
         else if(this._paging == "vertical")
         {
            this.getVisibleIndicesAtScrollPositionWithVerticalPaging(param1,param2,param3,param4,param5,param6);
         }
         else
         {
            this.getVisibleIndicesAtScrollPositionWithoutPaging(param1,param2,param3,param4,param5,param6);
         }
         return param6;
      }
      
      public function getScrollPositionForIndex(param1:int, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number, param7:Point = null) : Point
      {
         var _loc13_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc11_:int = 0;
         var _loc8_:* = null;
         var _loc18_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc19_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:int = 0;
         if(!param7)
         {
            param7 = new Point();
         }
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem();
            _loc13_ = !!this._typicalItem?this._typicalItem.width:0;
            _loc9_ = !!this._typicalItem?this._typicalItem.height:0;
         }
         var _loc14_:int = param2.length;
         var _loc12_:* = Number(!!this._useVirtualLayout?_loc13_:0);
         var _loc20_:* = Number(!!this._useVirtualLayout?_loc9_:0);
         if(!this._useVirtualLayout)
         {
            _loc11_ = 0;
            while(_loc11_ < _loc14_)
            {
               _loc8_ = param2[_loc11_];
               if(_loc8_)
               {
                  if(!(_loc8_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc8_).includeInLayout))
                  {
                     _loc18_ = _loc8_.width;
                     _loc10_ = _loc8_.height;
                     if(_loc18_ > _loc12_)
                     {
                        _loc12_ = _loc18_;
                     }
                     if(_loc10_ > _loc20_)
                     {
                        _loc20_ = _loc10_;
                     }
                  }
               }
               _loc11_++;
            }
         }
         if(_loc12_ < 0)
         {
            _loc12_ = 0;
         }
         if(_loc20_ < 0)
         {
            _loc20_ = 0;
         }
         if(this._useSquareTiles)
         {
            if(_loc12_ > _loc20_)
            {
               _loc20_ = _loc12_;
            }
            else if(_loc20_ > _loc12_)
            {
               _loc12_ = _loc20_;
            }
         }
         var _loc17_:int = (param5 - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc12_ + this._horizontalGap);
         if(_loc17_ < 1)
         {
            _loc17_ = 1;
         }
         else if(this._requestedColumnCount > 0 && _loc17_ > this._requestedColumnCount)
         {
            _loc17_ = this._requestedColumnCount;
         }
         if(this._paging != "none")
         {
            _loc19_ = (param6 - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc20_ + this._verticalGap);
            if(_loc19_ < 1)
            {
               _loc19_ = 1;
            }
            _loc15_ = _loc17_ * _loc19_;
            _loc16_ = param1 / _loc15_;
            if(this._paging == "horizontal")
            {
               param7.x = _loc16_ * param5;
               param7.y = 0;
            }
            else
            {
               param7.x = 0;
               param7.y = _loc16_ * param6;
            }
         }
         else
         {
            param7.x = 0;
            param7.y = this._paddingTop + (_loc20_ + this._verticalGap) * (int(param1 / _loc17_)) - Math.round((param6 - _loc20_) / 2);
         }
         return param7;
      }
      
      protected function applyVisible(param1:Vector.<DisplayObject>, param2:int, param3:int, param4:Number, param5:Number, param6:Number, param7:Number) : void
      {
         var _loc10_:* = 0;
         var _loc8_:* = null;
         var _loc9_:Number = NaN;
         var _loc11_:Number = NaN;
         _loc10_ = param2;
         while(_loc10_ <= param3)
         {
            _loc8_ = param1[_loc10_];
            if(!(_loc8_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc8_).includeInLayout))
            {
               _loc9_ = _loc8_.x - _loc8_.pivotX;
               _loc11_ = _loc8_.y - _loc8_.pivotY;
               _loc8_.visible = _loc9_ + _loc8_.width >= param4 && _loc9_ < param5 && _loc11_ + _loc8_.height >= param6 && _loc11_ < param7;
            }
            _loc10_++;
         }
      }
      
      protected function applyHorizontalAlign(param1:Vector.<DisplayObject>, param2:int, param3:int, param4:Number, param5:Number) : void
      {
         var _loc8_:* = 0;
         var _loc6_:* = null;
         if(param4 >= param5)
         {
            return;
         }
         var _loc7_:* = 0;
         if(this._horizontalAlign == "right")
         {
            _loc7_ = Number(param5 - param4);
         }
         else if(this._horizontalAlign != "left")
         {
            _loc7_ = Number(Math.round((param5 - param4) / 2));
         }
         if(_loc7_ != 0)
         {
            _loc8_ = param2;
            while(_loc8_ <= param3)
            {
               _loc6_ = param1[_loc8_];
               if(!(_loc6_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc6_).includeInLayout))
               {
                  _loc6_.x = _loc6_.x + _loc7_;
               }
               _loc8_++;
            }
         }
      }
      
      protected function applyVerticalAlign(param1:Vector.<DisplayObject>, param2:int, param3:int, param4:Number, param5:Number) : void
      {
         var _loc7_:* = 0;
         var _loc6_:* = null;
         if(param4 >= param5)
         {
            return;
         }
         var _loc8_:* = 0;
         if(this._verticalAlign == "bottom")
         {
            _loc8_ = Number(param5 - param4);
         }
         else if(this._verticalAlign == "middle")
         {
            _loc8_ = Number(Math.round((param5 - param4) / 2));
         }
         if(_loc8_ != 0)
         {
            _loc7_ = param2;
            while(_loc7_ <= param3)
            {
               _loc6_ = param1[_loc7_];
               if(!(_loc6_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc6_).includeInLayout))
               {
                  _loc6_.y = _loc6_.y + _loc8_;
               }
               _loc7_++;
            }
         }
      }
      
      protected function getVisibleIndicesAtScrollPositionWithHorizontalPaging(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int>) : void
      {
         var _loc10_:int = 0;
         var _loc17_:* = 0;
         var _loc22_:int = 0;
         var _loc14_:int = 0;
         var _loc13_:int = 0;
         var _loc24_:int = 0;
         this.prepareTypicalItem();
         var _loc19_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc16_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc18_:* = _loc19_;
         var _loc26_:* = _loc16_;
         if(_loc18_ < 0)
         {
            _loc18_ = 0;
         }
         if(_loc26_ < 0)
         {
            _loc26_ = 0;
         }
         if(this._useSquareTiles)
         {
            if(_loc18_ > _loc26_)
            {
               _loc26_ = _loc18_;
            }
            else if(_loc26_ > _loc18_)
            {
               _loc18_ = _loc26_;
            }
         }
         var _loc21_:int = (param3 - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc18_ + this._horizontalGap);
         if(_loc21_ < 1)
         {
            _loc21_ = 1;
         }
         else if(this._requestedColumnCount > 0 && _loc21_ > this._requestedColumnCount)
         {
            _loc21_ = this._requestedColumnCount;
         }
         var _loc23_:int = (param4 - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc26_ + this._verticalGap);
         if(_loc23_ < 1)
         {
            _loc23_ = 1;
         }
         var _loc20_:int = _loc21_ * _loc23_;
         var _loc11_:* = int(_loc20_ + 2 * _loc23_);
         if(_loc11_ > param5)
         {
            _loc11_ = param5;
         }
         var _loc12_:int = Math.round(param1 / param3);
         var _loc25_:int = _loc12_ * _loc20_;
         var _loc9_:Number = _loc21_ * (_loc18_ + this._horizontalGap) - this._horizontalGap;
         var _loc8_:* = 0;
         var _loc27_:* = 0;
         if(_loc9_ < param3)
         {
            if(this._horizontalAlign == "right")
            {
               _loc8_ = Number(param3 - this._paddingLeft - this._paddingRight - _loc9_);
               _loc27_ = 0;
            }
            else if(this._horizontalAlign == "center")
            {
               _loc27_ = Number(Math.round((param3 - this._paddingLeft - this._paddingRight - _loc9_) / 2));
               _loc8_ = Number(Math.round((param3 - this._paddingLeft - this._paddingRight - _loc9_) / 2));
            }
            else if(this._horizontalAlign == "left")
            {
               _loc8_ = 0;
               _loc27_ = Number(param3 - this._paddingLeft - this._paddingRight - _loc9_);
            }
         }
         var _loc7_:int = 0;
         var _loc28_:Number = _loc12_ * param3;
         var _loc15_:* = Number(param1 - _loc28_);
         if(_loc15_ < 0)
         {
            _loc15_ = Number(-_loc15_ - this._paddingRight - _loc27_);
            if(_loc15_ < 0)
            {
               _loc15_ = 0;
            }
            _loc7_ = -Math.floor(_loc15_ / (_loc18_ + this._horizontalGap)) - 1;
            _loc25_ = _loc25_ + (-_loc20_ + _loc21_ + _loc7_);
         }
         else if(_loc15_ > 0)
         {
            _loc15_ = Number(_loc15_ - this._paddingLeft - _loc8_);
            if(_loc15_ < 0)
            {
               _loc15_ = 0;
            }
            _loc7_ = Math.floor(_loc15_ / (_loc18_ + this._horizontalGap));
            _loc25_ = _loc25_ + _loc7_;
         }
         if(_loc25_ < 0)
         {
            _loc25_ = 0;
            _loc7_ = 0;
         }
         if(_loc25_ + _loc11_ >= param5)
         {
            _loc10_ = param6.length;
            _loc25_ = param5 - _loc11_;
            _loc17_ = _loc25_;
            while(_loc17_ < param5)
            {
               param6[_loc10_] = _loc17_;
               _loc10_++;
               _loc17_++;
            }
         }
         else
         {
            _loc22_ = 0;
            _loc14_ = (_loc21_ + _loc7_) % _loc21_;
            _loc13_ = int(_loc25_ / _loc20_) * _loc20_;
            _loc17_ = _loc25_;
            _loc24_ = 0;
            do
            {
               if(_loc17_ < param5)
               {
                  param6[_loc24_] = _loc17_;
                  _loc24_++;
               }
               _loc22_++;
               if(_loc22_ == _loc23_)
               {
                  _loc22_ = 0;
                  _loc14_++;
                  if(_loc14_ == _loc21_)
                  {
                     _loc14_ = 0;
                     _loc13_ = _loc13_ + _loc20_;
                  }
                  _loc17_ = int(_loc13_ + _loc14_ - _loc21_);
               }
               _loc17_ = int(_loc17_ + _loc21_);
            }
            while(_loc24_ < _loc11_ && _loc13_ < param5);
            
         }
      }
      
      protected function getVisibleIndicesAtScrollPositionWithVerticalPaging(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int>) : void
      {
         var _loc15_:* = 0;
         this.prepareTypicalItem();
         var _loc17_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc14_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc16_:* = _loc17_;
         var _loc24_:* = _loc14_;
         if(_loc16_ < 0)
         {
            _loc16_ = 0;
         }
         if(_loc24_ < 0)
         {
            _loc24_ = 0;
         }
         if(this._useSquareTiles)
         {
            if(_loc16_ > _loc24_)
            {
               _loc24_ = _loc16_;
            }
            else if(_loc24_ > _loc16_)
            {
               _loc16_ = _loc24_;
            }
         }
         var _loc20_:int = (param3 - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc16_ + this._horizontalGap);
         if(_loc20_ < 1)
         {
            _loc20_ = 1;
         }
         else if(this._requestedColumnCount > 0 && _loc20_ > this._requestedColumnCount)
         {
            _loc20_ = this._requestedColumnCount;
         }
         var _loc22_:int = (param4 - this._paddingTop - this._paddingBottom + this._verticalGap) / (_loc24_ + this._verticalGap);
         if(_loc22_ < 1)
         {
            _loc22_ = 1;
         }
         var _loc19_:int = _loc20_ * _loc22_;
         var _loc11_:* = int(_loc19_ + 2 * _loc20_);
         if(_loc11_ > param5)
         {
            _loc11_ = param5;
         }
         var _loc12_:int = Math.round(param2 / param4);
         var _loc23_:int = _loc12_ * _loc19_;
         var _loc8_:Number = _loc22_ * (_loc24_ + this._verticalGap) - this._verticalGap;
         var _loc7_:* = 0;
         var _loc9_:* = 0;
         if(_loc8_ < param4)
         {
            if(this._verticalAlign == "bottom")
            {
               _loc7_ = Number(param4 - this._paddingTop - this._paddingBottom - _loc8_);
               _loc9_ = 0;
            }
            else if(this._verticalAlign == "middle")
            {
               _loc9_ = Number(Math.round((param4 - this._paddingTop - this._paddingBottom - _loc8_) / 2));
               _loc7_ = Number(Math.round((param4 - this._paddingTop - this._paddingBottom - _loc8_) / 2));
            }
            else if(this._verticalAlign == "top")
            {
               _loc7_ = 0;
               _loc9_ = Number(param4 - this._paddingTop - this._paddingBottom - _loc8_);
            }
         }
         var _loc18_:int = 0;
         var _loc25_:Number = _loc12_ * param4;
         var _loc13_:* = Number(param2 - _loc25_);
         if(_loc13_ < 0)
         {
            _loc13_ = Number(-_loc13_ - this._paddingBottom - _loc9_);
            if(_loc13_ < 0)
            {
               _loc13_ = 0;
            }
            _loc18_ = -Math.floor(_loc13_ / (_loc24_ + this._verticalGap)) - 1;
            _loc23_ = _loc23_ + _loc20_ * _loc18_;
         }
         else if(_loc13_ > 0)
         {
            _loc13_ = Number(_loc13_ - this._paddingTop - _loc7_);
            if(_loc13_ < 0)
            {
               _loc13_ = 0;
            }
            _loc18_ = Math.floor(_loc13_ / (_loc24_ + this._verticalGap));
            _loc23_ = _loc23_ + _loc20_ * _loc18_;
         }
         if(_loc23_ < 0)
         {
            _loc23_ = 0;
            _loc18_ = 0;
         }
         var _loc21_:* = int(_loc23_ + _loc11_);
         if(_loc21_ > param5)
         {
            _loc21_ = param5;
         }
         _loc23_ = _loc21_ - _loc11_;
         var _loc10_:int = param6.length;
         _loc15_ = _loc23_;
         while(_loc15_ < _loc21_)
         {
            param6[_loc10_] = _loc15_;
            _loc10_++;
            _loc15_++;
         }
      }
      
      protected function getVisibleIndicesAtScrollPositionWithoutPaging(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int>) : void
      {
         var _loc8_:* = 0;
         this.prepareTypicalItem();
         var _loc11_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc7_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc9_:* = _loc11_;
         var _loc19_:* = _loc7_;
         if(_loc9_ < 0)
         {
            _loc9_ = 0;
         }
         if(_loc19_ < 0)
         {
            _loc19_ = 0;
         }
         if(this._useSquareTiles)
         {
            if(_loc9_ > _loc19_)
            {
               _loc19_ = _loc9_;
            }
            else if(_loc19_ > _loc9_)
            {
               _loc9_ = _loc19_;
            }
         }
         var _loc14_:int = (param3 - this._paddingLeft - this._paddingRight + this._horizontalGap) / (_loc9_ + this._horizontalGap);
         if(_loc14_ < 1)
         {
            _loc14_ = 1;
         }
         else if(this._requestedColumnCount > 0 && _loc14_ > this._requestedColumnCount)
         {
            _loc14_ = this._requestedColumnCount;
         }
         var _loc17_:int = Math.ceil((param4 + this._verticalGap) / (_loc19_ + this._verticalGap)) + 1;
         var _loc13_:* = int(_loc17_ * _loc14_);
         if(_loc13_ > param5)
         {
            _loc13_ = param5;
         }
         var _loc10_:int = 0;
         var _loc20_:Number = Math.ceil(param5 / _loc14_) * (_loc19_ + this._verticalGap) - this._verticalGap;
         if(_loc20_ < param4)
         {
            if(this._verticalAlign == "bottom")
            {
               _loc10_ = Math.ceil((param4 - _loc20_) / (_loc19_ + this._verticalGap));
            }
            else if(this._verticalAlign == "middle")
            {
               _loc10_ = Math.ceil((param4 - _loc20_) / (_loc19_ + this._verticalGap) / 2);
            }
         }
         var _loc16_:int = -_loc10_ + Math.floor((param2 - this._paddingTop + this._verticalGap) / (_loc19_ + this._verticalGap));
         var _loc18_:int = _loc16_ * _loc14_;
         if(_loc18_ < 0)
         {
            _loc18_ = 0;
         }
         var _loc15_:* = int(_loc18_ + _loc13_);
         if(_loc15_ > param5)
         {
            _loc15_ = param5;
         }
         _loc18_ = _loc15_ - _loc13_;
         var _loc12_:int = param6.length;
         _loc8_ = _loc18_;
         while(_loc8_ < _loc15_)
         {
            param6[_loc12_] = _loc8_;
            _loc12_++;
            _loc8_++;
         }
      }
      
      protected function validateItems(param1:Vector.<DisplayObject>) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = param1.length;
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = param1[_loc3_];
            if(!(_loc2_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc2_).includeInLayout))
            {
               if(_loc2_ is IValidating)
               {
                  IValidating(_loc2_).validate();
               }
            }
            _loc3_++;
         }
      }
      
      protected function prepareTypicalItem() : void
      {
         if(!this._typicalItem)
         {
            return;
         }
         if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.width = this._typicalItemWidth;
            this._typicalItem.height = this._typicalItemHeight;
         }
         if(this._typicalItem is IValidating)
         {
            IValidating(this._typicalItem).validate();
         }
      }
   }
}
