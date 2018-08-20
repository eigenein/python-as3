package feathers.layout
{
   import feathers.core.IFeathersControl;
   import feathers.core.IValidating;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class HorizontalLayout extends EventDispatcher implements IVariableVirtualLayout, ITrimmedVirtualLayout
   {
      
      public static const VERTICAL_ALIGN_TOP:String = "top";
      
      public static const VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const VERTICAL_ALIGN_JUSTIFY:String = "justify";
      
      public static const HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const HORIZONTAL_ALIGN_RIGHT:String = "right";
       
      
      protected var _widthCache:Array;
      
      protected var _discoveredItemsCache:Vector.<DisplayObject>;
      
      protected var _gap:Number = 0;
      
      protected var _firstGap:Number = NaN;
      
      protected var _lastGap:Number = NaN;
      
      protected var _paddingTop:Number = 0;
      
      protected var _paddingRight:Number = 0;
      
      protected var _paddingBottom:Number = 0;
      
      protected var _paddingLeft:Number = 0;
      
      protected var _verticalAlign:String = "top";
      
      protected var _horizontalAlign:String = "left";
      
      protected var _useVirtualLayout:Boolean = true;
      
      protected var _hasVariableItemDimensions:Boolean = false;
      
      protected var _distributeWidths:Boolean = false;
      
      protected var _manageVisibility:Boolean = false;
      
      protected var _beforeVirtualizedItemCount:int = 0;
      
      protected var _afterVirtualizedItemCount:int = 0;
      
      protected var _typicalItem:DisplayObject;
      
      protected var _resetTypicalItemDimensionsOnMeasure:Boolean = false;
      
      protected var _typicalItemWidth:Number = NaN;
      
      protected var _typicalItemHeight:Number = NaN;
      
      protected var _scrollPositionHorizontalAlign:String = "center";
      
      public function HorizontalLayout()
      {
         _widthCache = [];
         _discoveredItemsCache = new Vector.<DisplayObject>(0);
         super();
      }
      
      public function get gap() : Number
      {
         return this._gap;
      }
      
      public function set gap(param1:Number) : void
      {
         if(this._gap == param1)
         {
            return;
         }
         this._gap = param1;
         this.dispatchEventWith("change");
      }
      
      public function get firstGap() : Number
      {
         return this._firstGap;
      }
      
      public function set firstGap(param1:Number) : void
      {
         if(this._firstGap == param1)
         {
            return;
         }
         this._firstGap = param1;
         this.dispatchEventWith("change");
      }
      
      public function get lastGap() : Number
      {
         return this._lastGap;
      }
      
      public function set lastGap(param1:Number) : void
      {
         if(this._lastGap == param1)
         {
            return;
         }
         this._lastGap = param1;
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
      
      [Inspectable(type="String",enumeration="top,middle,bottom,justify")]
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
      
      public function get hasVariableItemDimensions() : Boolean
      {
         return this._hasVariableItemDimensions;
      }
      
      public function set hasVariableItemDimensions(param1:Boolean) : void
      {
         if(this._hasVariableItemDimensions == param1)
         {
            return;
         }
         this._hasVariableItemDimensions = param1;
         this.dispatchEventWith("change");
      }
      
      public function get distributeWidths() : Boolean
      {
         return this._distributeWidths;
      }
      
      public function set distributeWidths(param1:Boolean) : void
      {
         if(this._distributeWidths == param1)
         {
            return;
         }
         this._distributeWidths = param1;
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
      
      public function get beforeVirtualizedItemCount() : int
      {
         return this._beforeVirtualizedItemCount;
      }
      
      public function set beforeVirtualizedItemCount(param1:int) : void
      {
         if(this._beforeVirtualizedItemCount == param1)
         {
            return;
         }
         this._beforeVirtualizedItemCount = param1;
         this.dispatchEventWith("change");
      }
      
      public function get afterVirtualizedItemCount() : int
      {
         return this._afterVirtualizedItemCount;
      }
      
      public function set afterVirtualizedItemCount(param1:int) : void
      {
         if(this._afterVirtualizedItemCount == param1)
         {
            return;
         }
         this._afterVirtualizedItemCount = param1;
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
      
      [Inspectable(type="String",enumeration="left,center,right")]
      public function get scrollPositionHorizontalAlign() : String
      {
         return this._scrollPositionHorizontalAlign;
      }
      
      public function set scrollPositionHorizontalAlign(param1:String) : void
      {
         this._scrollPositionHorizontalAlign = param1;
      }
      
      public function get requiresLayoutOnScroll() : Boolean
      {
         return this._manageVisibility || this._useVirtualLayout;
      }
      
      public function layout(param1:Vector.<DisplayObject>, param2:ViewPortBounds = null, param3:LayoutBoundsResult = null) : LayoutBoundsResult
      {
         var _loc32_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc30_:int = 0;
         var _loc24_:* = null;
         var _loc13_:int = 0;
         var _loc17_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc18_:* = NaN;
         var _loc7_:* = NaN;
         var _loc41_:* = NaN;
         var _loc6_:* = null;
         var _loc22_:* = null;
         var _loc15_:* = NaN;
         var _loc9_:* = null;
         var _loc45_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc44_:Number = !!param2?param2.scrollX:0;
         var _loc42_:Number = !!param2?param2.scrollY:0;
         var _loc37_:Number = !!param2?param2.x:0;
         var _loc39_:Number = !!param2?param2.y:0;
         var _loc31_:Number = !!param2?param2.minWidth:0;
         var _loc12_:Number = !!param2?param2.minHeight:0;
         var _loc20_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc16_:Number = !!param2?param2.maxHeight:Infinity;
         var _loc36_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc43_:Number = !!param2?param2.explicitHeight:NaN;
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem(_loc43_ - this._paddingTop - this._paddingBottom);
            _loc32_ = !!this._typicalItem?this._typicalItem.width:0;
            _loc28_ = !!this._typicalItem?this._typicalItem.height:0;
         }
         if(!this._useVirtualLayout || this._hasVariableItemDimensions || this._distributeWidths || this._verticalAlign != "justify" || _loc43_ !== _loc43_)
         {
            this.validateItems(param1,_loc43_ - this._paddingTop - this._paddingBottom,_loc36_);
         }
         if(!this._useVirtualLayout)
         {
            this.applyPercentWidths(param1,_loc36_,_loc31_,_loc20_);
         }
         var _loc29_:Number = NaN;
         if(this._distributeWidths)
         {
            _loc29_ = this.calculateDistributedWidth(param1,_loc36_,_loc31_,_loc20_);
         }
         var _loc8_:* = _loc29_ === _loc29_;
         this._discoveredItemsCache.length = 0;
         var _loc10_:* = this._firstGap === this._firstGap;
         var _loc38_:* = this._lastGap === this._lastGap;
         var _loc23_:* = Number(!!this._useVirtualLayout?_loc28_:0);
         var _loc11_:Number = _loc37_ + this._paddingLeft;
         var _loc33_:int = param1.length;
         var _loc34_:* = _loc33_;
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc34_ = int(_loc34_ + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount));
            _loc11_ = _loc11_ + this._beforeVirtualizedItemCount * (_loc32_ + this._gap);
            if(_loc10_ && this._beforeVirtualizedItemCount > 0)
            {
               _loc11_ = _loc11_ - this._gap + this._firstGap;
            }
         }
         var _loc21_:int = _loc34_ - 2;
         var _loc14_:int = 0;
         _loc30_ = 0;
         while(_loc30_ < _loc33_)
         {
            _loc24_ = param1[_loc30_];
            _loc13_ = _loc30_ + this._beforeVirtualizedItemCount;
            _loc17_ = this._gap;
            if(_loc10_ && _loc13_ == 0)
            {
               _loc17_ = this._firstGap;
            }
            else if(_loc38_ && _loc13_ > 0 && _loc13_ == _loc21_)
            {
               _loc17_ = this._lastGap;
            }
            if(this._useVirtualLayout && this._hasVariableItemDimensions && _loc13_ < this._widthCache.length)
            {
               _loc35_ = this._widthCache[_loc13_];
            }
            if(this._useVirtualLayout && !_loc24_)
            {
               if(!this._hasVariableItemDimensions || _loc35_ !== _loc35_)
               {
                  _loc11_ = _loc11_ + (_loc32_ + _loc17_);
               }
               else
               {
                  _loc11_ = _loc11_ + (_loc35_ + _loc17_);
               }
            }
            else if(!(_loc24_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc24_).includeInLayout))
            {
               _loc24_.x = _loc24_.pivotX + _loc11_;
               if(_loc8_)
               {
                  _loc18_ = _loc29_;
                  _loc24_.width = _loc18_;
               }
               else
               {
                  _loc18_ = Number(_loc24_.width);
               }
               _loc7_ = Number(_loc24_.height);
               if(this._useVirtualLayout)
               {
                  if(this._hasVariableItemDimensions)
                  {
                     if(_loc18_ != _loc35_)
                     {
                        this._widthCache[_loc13_] = _loc18_;
                        this.dispatchEventWith("change");
                     }
                  }
                  else if(_loc32_ >= 0)
                  {
                     _loc18_ = _loc32_;
                     _loc24_.width = _loc18_;
                  }
               }
               _loc11_ = _loc11_ + (_loc18_ + _loc17_);
               if(_loc7_ > _loc23_)
               {
                  _loc23_ = _loc7_;
               }
               if(this._useVirtualLayout)
               {
                  this._discoveredItemsCache[_loc14_] = _loc24_;
                  _loc14_++;
               }
            }
            _loc30_++;
         }
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc11_ = _loc11_ + this._afterVirtualizedItemCount * (_loc32_ + this._gap);
            if(_loc38_ && this._afterVirtualizedItemCount > 0)
            {
               _loc11_ = _loc11_ - this._gap + this._lastGap;
            }
         }
         var _loc25_:Vector.<DisplayObject> = !!this._useVirtualLayout?this._discoveredItemsCache:param1;
         var _loc26_:int = _loc25_.length;
         var _loc4_:Number = _loc23_ + this._paddingTop + this._paddingBottom;
         var _loc5_:* = _loc43_;
         if(_loc5_ !== _loc5_)
         {
            _loc5_ = _loc4_;
            if(_loc5_ < _loc12_)
            {
               _loc5_ = _loc12_;
            }
            else if(_loc5_ > _loc16_)
            {
               _loc5_ = _loc16_;
            }
         }
         var _loc19_:Number = _loc11_ - this._gap + this._paddingRight - _loc37_;
         var _loc27_:* = _loc36_;
         if(_loc27_ !== _loc27_)
         {
            _loc27_ = _loc19_;
            if(_loc27_ < _loc31_)
            {
               _loc27_ = _loc31_;
            }
            else if(_loc27_ > _loc20_)
            {
               _loc27_ = _loc20_;
            }
         }
         if(_loc19_ < _loc27_)
         {
            _loc41_ = 0;
            if(this._horizontalAlign == "right")
            {
               _loc41_ = Number(_loc27_ - _loc19_);
            }
            else if(this._horizontalAlign == "center")
            {
               _loc41_ = Number(Math.round((_loc27_ - _loc19_) / 2));
            }
            if(_loc41_ != 0)
            {
               _loc30_ = 0;
               while(_loc30_ < _loc26_)
               {
                  _loc24_ = _loc25_[_loc30_];
                  if(!(_loc24_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc24_).includeInLayout))
                  {
                     _loc24_.x = _loc24_.x + _loc41_;
                  }
                  _loc30_++;
               }
            }
         }
         _loc30_ = 0;
         while(_loc30_ < _loc26_)
         {
            _loc24_ = _loc25_[_loc30_];
            if(!(_loc24_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc24_).includeInLayout))
            {
               if(this._verticalAlign == "justify")
               {
                  _loc24_.y = _loc24_.pivotY + _loc39_ + this._paddingTop;
                  _loc24_.height = _loc5_ - this._paddingTop - this._paddingBottom;
               }
               else
               {
                  _loc6_ = _loc24_ as ILayoutDisplayObject;
                  if(_loc6_)
                  {
                     _loc22_ = _loc6_.layoutData as HorizontalLayoutData;
                     if(_loc22_)
                     {
                        _loc15_ = Number(_loc22_.percentHeight);
                        if(_loc15_ === _loc15_)
                        {
                           if(_loc15_ < 0)
                           {
                              _loc15_ = 0;
                           }
                           if(_loc15_ > 100)
                           {
                              _loc15_ = 100;
                           }
                           _loc7_ = Number(_loc15_ * (_loc5_ - this._paddingTop - this._paddingBottom) / 100);
                           if(_loc24_ is IFeathersControl)
                           {
                              _loc9_ = IFeathersControl(_loc24_);
                              _loc45_ = _loc9_.minHeight;
                              if(_loc7_ < _loc45_)
                              {
                                 _loc7_ = _loc45_;
                              }
                              else
                              {
                                 _loc40_ = _loc9_.maxHeight;
                                 if(_loc7_ > _loc40_)
                                 {
                                    _loc7_ = _loc40_;
                                 }
                              }
                           }
                           _loc24_.height = _loc7_;
                        }
                     }
                  }
                  var _loc46_:* = this._verticalAlign;
                  if("bottom" !== _loc46_)
                  {
                     if("middle" !== _loc46_)
                     {
                        _loc24_.y = _loc24_.pivotY + _loc39_ + this._paddingTop;
                     }
                     else
                     {
                        _loc24_.y = _loc24_.pivotY + _loc39_ + this._paddingTop + Math.round((_loc5_ - this._paddingTop - this._paddingBottom - _loc24_.height) / 2);
                     }
                  }
                  else
                  {
                     _loc24_.y = _loc24_.pivotY + _loc39_ + _loc5_ - this._paddingBottom - _loc24_.height;
                  }
               }
               if(this.manageVisibility)
               {
                  _loc24_.visible = _loc24_.x - _loc24_.pivotX + _loc24_.width >= _loc37_ + _loc44_ && _loc24_.x - _loc24_.pivotX < _loc44_ + _loc27_;
               }
            }
            _loc30_++;
         }
         this._discoveredItemsCache.length = 0;
         if(!param3)
         {
            param3 = new LayoutBoundsResult();
         }
         param3.contentWidth = _loc19_;
         param3.contentHeight = this._verticalAlign == "justify"?_loc5_:Number(_loc4_);
         param3.viewPortWidth = _loc27_;
         param3.viewPortHeight = _loc5_;
         return param3;
      }
      
      public function measureViewPort(param1:int, param2:ViewPortBounds = null, param3:Point = null) : Point
      {
         var _loc12_:* = NaN;
         var _loc4_:* = NaN;
         var _loc7_:int = 0;
         var _loc13_:Number = NaN;
         var _loc14_:* = NaN;
         var _loc10_:* = NaN;
         if(!param3)
         {
            param3 = new Point();
         }
         if(!this._useVirtualLayout)
         {
            throw new IllegalOperationError("measureViewPort() may be called only if useVirtualLayout is true.");
         }
         var _loc15_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc20_:Number = !!param2?param2.explicitHeight:NaN;
         var _loc5_:* = _loc15_ !== _loc15_;
         var _loc19_:* = _loc20_ !== _loc20_;
         if(!_loc5_ && !_loc19_)
         {
            param3.x = _loc15_;
            param3.y = _loc20_;
            return param3;
         }
         var _loc8_:Number = !!param2?param2.minWidth:0;
         var _loc16_:Number = !!param2?param2.minHeight:0;
         var _loc21_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc18_:Number = !!param2?param2.maxHeight:Infinity;
         this.prepareTypicalItem(_loc20_ - this._paddingTop - this._paddingBottom);
         var _loc11_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc6_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc9_:* = this._firstGap === this._firstGap;
         var _loc17_:* = this._lastGap === this._lastGap;
         if(this._distributeWidths)
         {
            _loc12_ = Number((_loc11_ + this._gap) * param1);
         }
         else
         {
            _loc12_ = 0;
            _loc4_ = _loc6_;
            if(!this._hasVariableItemDimensions)
            {
               _loc12_ = Number(_loc12_ + (_loc11_ + this._gap) * param1);
            }
            else
            {
               _loc7_ = 0;
               while(_loc7_ < param1)
               {
                  _loc13_ = this._widthCache[_loc7_];
                  if(_loc13_ !== _loc13_)
                  {
                     _loc12_ = Number(_loc12_ + (_loc11_ + this._gap));
                  }
                  else
                  {
                     _loc12_ = Number(_loc12_ + (_loc13_ + this._gap));
                  }
                  _loc7_++;
               }
            }
         }
         _loc12_ = Number(_loc12_ - this._gap);
         if(_loc9_ && param1 > 1)
         {
            _loc12_ = Number(_loc12_ - this._gap + this._firstGap);
         }
         if(_loc17_ && param1 > 2)
         {
            _loc12_ = Number(_loc12_ - this._gap + this._lastGap);
         }
         if(_loc5_)
         {
            _loc14_ = Number(_loc12_ + this._paddingLeft + this._paddingRight);
            if(_loc14_ < _loc8_)
            {
               _loc14_ = _loc8_;
            }
            else if(_loc14_ > _loc21_)
            {
               _loc14_ = _loc21_;
            }
            param3.x = _loc14_;
         }
         else
         {
            param3.x = _loc15_;
         }
         if(_loc19_)
         {
            _loc10_ = Number(_loc4_ + this._paddingTop + this._paddingBottom);
            if(_loc10_ < _loc16_)
            {
               _loc10_ = _loc16_;
            }
            else if(_loc10_ > _loc18_)
            {
               _loc10_ = _loc18_;
            }
            param3.y = _loc10_;
         }
         else
         {
            param3.y = _loc20_;
         }
         return param3;
      }
      
      public function resetVariableVirtualCache() : void
      {
         this._widthCache.length = 0;
      }
      
      public function resetVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void
      {
         delete this._widthCache[param1];
         if(param2)
         {
            this._widthCache[param1] = param2.width;
            this.dispatchEventWith("change");
         }
      }
      
      public function addToVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void
      {
         var _loc3_:* = !!param2?param2.width:undefined;
         this._widthCache.splice(param1,0,_loc3_);
      }
      
      public function removeFromVariableVirtualCacheAtIndex(param1:int) : void
      {
         this._widthCache.splice(param1,1);
      }
      
      public function getVisibleIndicesAtScrollPosition(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int> = null) : Vector.<int>
      {
         var _loc8_:Number = NaN;
         var _loc27_:int = 0;
         var _loc30_:int = 0;
         var _loc28_:int = 0;
         var _loc23_:* = 0;
         var _loc17_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc18_:* = NaN;
         var _loc10_:* = NaN;
         var _loc13_:int = 0;
         var _loc9_:int = 0;
         var _loc14_:int = 0;
         var _loc16_:* = 0;
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
         this.prepareTypicalItem(param4 - this._paddingTop - this._paddingBottom);
         var _loc24_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc21_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc11_:* = this._firstGap === this._firstGap;
         var _loc26_:* = this._lastGap === this._lastGap;
         var _loc7_:* = 0;
         var _loc15_:int = Math.ceil(param3 / (_loc24_ + this._gap));
         if(!this._hasVariableItemDimensions)
         {
            _loc8_ = param5 * (_loc24_ + this._gap) - this._gap;
            if(_loc11_ && param5 > 1)
            {
               _loc8_ = _loc8_ - this._gap + this._firstGap;
            }
            if(_loc26_ && param5 > 2)
            {
               _loc8_ = _loc8_ - this._gap + this._lastGap;
            }
            _loc27_ = 0;
            if(_loc8_ < param3)
            {
               if(this._horizontalAlign == "right")
               {
                  _loc27_ = Math.ceil((param3 - _loc8_) / (_loc24_ + this._gap));
               }
               else if(this._horizontalAlign == "center")
               {
                  _loc27_ = Math.ceil((param3 - _loc8_) / (_loc24_ + this._gap) / 2);
               }
            }
            _loc30_ = (param1 - this._paddingLeft) / (_loc24_ + this._gap);
            if(_loc30_ < 0)
            {
               _loc30_ = 0;
            }
            _loc30_ = _loc30_ - _loc27_;
            _loc28_ = _loc30_ + _loc15_;
            if(_loc28_ >= param5)
            {
               _loc28_ = param5 - 1;
            }
            _loc30_ = _loc28_ - _loc15_;
            if(_loc30_ < 0)
            {
               _loc30_ = 0;
            }
            _loc23_ = _loc30_;
            while(_loc23_ <= _loc28_)
            {
               param6[_loc7_] = _loc23_;
               _loc7_++;
               _loc23_++;
            }
            return param6;
         }
         var _loc19_:int = param5 - 2;
         var _loc20_:Number = param1 + param3;
         var _loc12_:Number = this._paddingLeft;
         _loc23_ = 0;
         while(_loc23_ < param5)
         {
            _loc17_ = this._gap;
            if(_loc11_ && _loc23_ == 0)
            {
               _loc17_ = this._firstGap;
            }
            else if(_loc26_ && _loc23_ > 0 && _loc23_ == _loc19_)
            {
               _loc17_ = this._lastGap;
            }
            _loc25_ = this._widthCache[_loc23_];
            if(_loc25_ !== _loc25_)
            {
               _loc18_ = _loc24_;
            }
            else
            {
               _loc18_ = _loc25_;
            }
            _loc10_ = _loc12_;
            _loc12_ = _loc12_ + (_loc18_ + _loc17_);
            if(_loc12_ > param1 && _loc10_ < _loc20_)
            {
               param6[_loc7_] = _loc23_;
               _loc7_++;
            }
            if(_loc12_ < _loc20_)
            {
               _loc23_++;
               continue;
            }
            break;
         }
         var _loc29_:int = param6.length;
         var _loc22_:int = _loc15_ - _loc29_;
         if(_loc22_ > 0 && _loc29_ > 0)
         {
            _loc13_ = param6[0];
            _loc9_ = _loc13_ - _loc22_;
            if(_loc9_ < 0)
            {
               _loc9_ = 0;
            }
            _loc23_ = int(_loc13_ - 1);
            while(_loc23_ >= _loc9_)
            {
               param6.unshift(_loc23_);
               _loc23_--;
            }
         }
         _loc29_ = param6.length;
         _loc7_ = _loc29_;
         _loc22_ = _loc15_ - _loc29_;
         if(_loc22_ > 0)
         {
            _loc14_ = _loc29_ > 0?param6[_loc29_ - 1] + 1:0;
            _loc16_ = int(_loc14_ + _loc22_);
            if(_loc16_ > param5)
            {
               _loc16_ = param5;
            }
            _loc23_ = _loc14_;
            while(_loc23_ < _loc16_)
            {
               param6[_loc7_] = _loc23_;
               _loc7_++;
               _loc23_++;
            }
         }
         return param6;
      }
      
      public function getScrollPositionForIndex(param1:int, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number, param7:Point = null) : Point
      {
         var _loc13_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc9_:* = null;
         var _loc19_:int = 0;
         var _loc17_:Number = NaN;
         var _loc22_:* = NaN;
         if(!param7)
         {
            param7 = new Point();
         }
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem(param6 - this._paddingTop - this._paddingBottom);
            _loc13_ = !!this._typicalItem?this._typicalItem.width:0;
            _loc10_ = !!this._typicalItem?this._typicalItem.height:0;
         }
         var _loc12_:* = this._firstGap === this._firstGap;
         var _loc20_:* = this._lastGap === this._lastGap;
         var _loc14_:Number = param3 + this._paddingLeft;
         var _loc23_:* = 0;
         var _loc21_:Number = this._gap;
         var _loc18_:int = 0;
         var _loc24_:* = 0;
         var _loc15_:int = param2.length;
         var _loc16_:* = _loc15_;
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc16_ = int(_loc16_ + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount));
            if(param1 < this._beforeVirtualizedItemCount)
            {
               _loc18_ = param1 + 1;
               _loc23_ = _loc13_;
               _loc21_ = this._gap;
            }
            else
            {
               _loc18_ = this._beforeVirtualizedItemCount;
               _loc24_ = Number(param1 - param2.length - this._beforeVirtualizedItemCount + 1);
               if(_loc24_ < 0)
               {
                  _loc24_ = 0;
               }
               _loc14_ = _loc14_ + _loc24_ * (_loc13_ + this._gap);
            }
            _loc14_ = _loc14_ + _loc18_ * (_loc13_ + this._gap);
         }
         param1 = param1 - (_loc18_ + _loc24_);
         var _loc8_:int = _loc16_ - 2;
         _loc11_ = 0;
         while(_loc11_ <= param1)
         {
            _loc9_ = param2[_loc11_];
            _loc19_ = _loc11_ + _loc18_;
            if(_loc12_ && _loc19_ == 0)
            {
               _loc21_ = this._firstGap;
            }
            else if(_loc20_ && _loc19_ > 0 && _loc19_ == _loc8_)
            {
               _loc21_ = this._lastGap;
            }
            else
            {
               _loc21_ = this._gap;
            }
            if(this._useVirtualLayout && this._hasVariableItemDimensions && _loc19_ < this._widthCache.length)
            {
               _loc17_ = this._widthCache[_loc19_];
            }
            if(this._useVirtualLayout && !_loc9_)
            {
               if(!this._hasVariableItemDimensions || _loc17_ !== _loc17_)
               {
                  _loc23_ = _loc13_;
               }
               else
               {
                  _loc23_ = _loc17_;
               }
            }
            else
            {
               _loc22_ = Number(_loc9_.width);
               if(this._useVirtualLayout)
               {
                  if(this._hasVariableItemDimensions)
                  {
                     if(_loc22_ != _loc17_)
                     {
                        this._widthCache[_loc19_] = _loc22_;
                        this.dispatchEventWith("change");
                     }
                  }
                  else if(_loc13_ >= 0)
                  {
                     _loc22_ = _loc13_;
                     _loc9_.width = _loc22_;
                  }
               }
               _loc23_ = _loc22_;
            }
            _loc14_ = _loc14_ + (_loc23_ + _loc21_);
            _loc11_++;
         }
         _loc14_ = _loc14_ - (_loc23_ + _loc21_);
         if(this._scrollPositionHorizontalAlign == "center")
         {
            _loc14_ = _loc14_ - Math.round((param5 - _loc23_) / 2);
         }
         else if(this._scrollPositionHorizontalAlign == "right")
         {
            _loc14_ = _loc14_ - (param5 - _loc23_);
         }
         param7.x = _loc14_;
         param7.y = 0;
         return param7;
      }
      
      protected function validateItems(param1:Vector.<DisplayObject>, param2:Number, param3:Number) : void
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc6_:Boolean = this._verticalAlign == "justify" && param2 === param2;
         var _loc7_:int = param1.length;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc4_ = param1[_loc5_];
            if(!(!_loc4_ || _loc4_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc4_).includeInLayout))
            {
               if(this._distributeWidths)
               {
                  _loc4_.width = param3;
               }
               if(_loc6_)
               {
                  _loc4_.height = param2;
               }
               if(_loc4_ is IValidating)
               {
                  IValidating(_loc4_).validate();
               }
            }
            _loc5_++;
         }
      }
      
      protected function prepareTypicalItem(param1:Number) : void
      {
         if(!this._typicalItem)
         {
            return;
         }
         if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.width = this._typicalItemWidth;
         }
         if(this._verticalAlign == "justify" && param1 === param1)
         {
            this._typicalItem.height = param1;
         }
         else if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.height = this._typicalItemHeight;
         }
         if(this._typicalItem is IValidating)
         {
            IValidating(this._typicalItem).validate();
         }
      }
      
      protected function calculateDistributedWidth(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc10_:* = NaN;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc9_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc11_:int = param1.length;
         if(param2 !== param2)
         {
            _loc10_ = 0;
            _loc8_ = 0;
            while(_loc8_ < _loc11_)
            {
               _loc5_ = param1[_loc8_];
               _loc9_ = _loc5_.width;
               if(_loc9_ > _loc10_)
               {
                  _loc10_ = _loc9_;
               }
               _loc8_++;
            }
            param2 = Number(_loc10_ * _loc11_ + this._paddingLeft + this._paddingRight + this._gap * (_loc11_ - 1));
            _loc7_ = false;
            if(param2 > param4)
            {
               param2 = param4;
               _loc7_ = true;
            }
            else if(param2 < param3)
            {
               param2 = param3;
               _loc7_ = true;
            }
            if(!_loc7_)
            {
               return _loc10_;
            }
         }
         var _loc6_:Number = param2 - this._paddingLeft - this._paddingRight - this._gap * (_loc11_ - 1);
         if(_loc11_ > 1 && this._firstGap === this._firstGap)
         {
            _loc6_ = _loc6_ + (this._gap - this._firstGap);
         }
         if(_loc11_ > 2 && this._lastGap === this._lastGap)
         {
            _loc6_ = _loc6_ + (this._gap - this._lastGap);
         }
         return _loc6_ / _loc11_;
      }
      
      protected function applyPercentWidths(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc9_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = null;
         var _loc15_:Number = NaN;
         var _loc12_:* = null;
         var _loc13_:Boolean = false;
         var _loc19_:Number = NaN;
         var _loc18_:* = NaN;
         var _loc17_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc20_:* = param2;
         this._discoveredItemsCache.length = 0;
         var _loc21_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc16_:int = param1.length;
         var _loc14_:int = 0;
         _loc9_ = 0;
         for(; _loc9_ < _loc16_; _loc9_++)
         {
            _loc6_ = param1[_loc9_];
            if(!(_loc6_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc6_).includeInLayout))
            {
               if(_loc6_ is ILayoutDisplayObject)
               {
                  _loc7_ = ILayoutDisplayObject(_loc6_);
                  _loc5_ = _loc7_.layoutData as HorizontalLayoutData;
                  if(_loc5_)
                  {
                     _loc15_ = _loc5_.percentWidth;
                     if(_loc15_ === _loc15_)
                     {
                        if(_loc7_ is IFeathersControl)
                        {
                           _loc12_ = IFeathersControl(_loc7_);
                           _loc10_ = Number(_loc10_ + _loc12_.minWidth);
                        }
                        _loc11_ = Number(_loc11_ + _loc15_);
                        this._discoveredItemsCache[_loc14_] = _loc6_;
                        _loc14_++;
                        continue;
                     }
                  }
               }
               _loc21_ = Number(_loc21_ + _loc6_.width);
               continue;
            }
         }
         _loc21_ = Number(_loc21_ + this._gap * (_loc16_ - 1));
         if(this._firstGap === this._firstGap && _loc16_ > 1)
         {
            _loc21_ = Number(_loc21_ + (this._firstGap - this._gap));
         }
         else if(this._lastGap === this._lastGap && _loc16_ > 2)
         {
            _loc21_ = Number(_loc21_ + (this._lastGap - this._gap));
         }
         _loc21_ = Number(_loc21_ + (this._paddingLeft + this._paddingRight));
         if(_loc11_ < 100)
         {
            _loc11_ = 100;
         }
         if(_loc20_ !== _loc20_)
         {
            _loc20_ = Number(_loc21_ + _loc10_);
            if(_loc20_ < param3)
            {
               _loc20_ = param3;
            }
            else if(_loc20_ > param4)
            {
               _loc20_ = param4;
            }
         }
         _loc20_ = Number(_loc20_ - _loc21_);
         if(_loc20_ < 0)
         {
            _loc20_ = 0;
         }
         do
         {
            _loc13_ = false;
            _loc19_ = _loc20_ / _loc11_;
            _loc9_ = 0;
            while(_loc9_ < _loc14_)
            {
               _loc7_ = ILayoutDisplayObject(this._discoveredItemsCache[_loc9_]);
               if(_loc7_)
               {
                  _loc5_ = HorizontalLayoutData(_loc7_.layoutData);
                  _loc15_ = _loc5_.percentWidth;
                  _loc18_ = Number(_loc19_ * _loc15_);
                  if(_loc7_ is IFeathersControl)
                  {
                     _loc12_ = IFeathersControl(_loc7_);
                     _loc17_ = _loc12_.minWidth;
                     if(_loc18_ < _loc17_)
                     {
                        _loc18_ = _loc17_;
                        _loc20_ = Number(_loc20_ - _loc18_);
                        _loc11_ = Number(_loc11_ - _loc15_);
                        this._discoveredItemsCache[_loc9_] = null;
                        _loc13_ = true;
                     }
                     else
                     {
                        _loc8_ = _loc12_.maxWidth;
                        if(_loc18_ > _loc8_)
                        {
                           _loc18_ = _loc8_;
                           _loc20_ = Number(_loc20_ - _loc18_);
                           _loc11_ = Number(_loc11_ - _loc15_);
                           this._discoveredItemsCache[_loc9_] = null;
                           _loc13_ = true;
                        }
                     }
                  }
                  _loc7_.width = _loc18_;
               }
               _loc9_++;
            }
         }
         while(_loc13_);
         
         this._discoveredItemsCache.length = 0;
      }
   }
}
