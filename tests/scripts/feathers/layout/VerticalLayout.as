package feathers.layout
{
   import feathers.core.IFeathersControl;
   import feathers.core.IValidating;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import starling.display.DisplayObject;
   import starling.events.EventDispatcher;
   
   [Event(name="change",type="starling.events.Event")]
   public class VerticalLayout extends EventDispatcher implements IVariableVirtualLayout, ITrimmedVirtualLayout
   {
      
      public static const VERTICAL_ALIGN_TOP:String = "top";
      
      public static const VERTICAL_ALIGN_MIDDLE:String = "middle";
      
      public static const VERTICAL_ALIGN_BOTTOM:String = "bottom";
      
      public static const HORIZONTAL_ALIGN_LEFT:String = "left";
      
      public static const HORIZONTAL_ALIGN_CENTER:String = "center";
      
      public static const HORIZONTAL_ALIGN_RIGHT:String = "right";
      
      public static const HORIZONTAL_ALIGN_JUSTIFY:String = "justify";
       
      
      protected var _heightCache:Array;
      
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
      
      protected var _distributeHeights:Boolean = false;
      
      protected var _manageVisibility:Boolean = false;
      
      protected var _beforeVirtualizedItemCount:int = 0;
      
      protected var _afterVirtualizedItemCount:int = 0;
      
      protected var _typicalItem:DisplayObject;
      
      protected var _resetTypicalItemDimensionsOnMeasure:Boolean = false;
      
      protected var _typicalItemWidth:Number = NaN;
      
      protected var _typicalItemHeight:Number = NaN;
      
      protected var _scrollPositionVerticalAlign:String = "middle";
      
      public function VerticalLayout()
      {
         _heightCache = [];
         _discoveredItemsCache = new Vector.<DisplayObject>(0);
         super();
      }
      
      public function get heightCache() : Array
      {
         return _heightCache;
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
      
      [Inspectable(type="String",enumeration="left,center,right,justify")]
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
      
      public function get distributeHeights() : Boolean
      {
         return this._distributeHeights;
      }
      
      public function set distributeHeights(param1:Boolean) : void
      {
         if(this._distributeHeights == param1)
         {
            return;
         }
         this._distributeHeights = param1;
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
      
      [Inspectable(type="String",enumeration="top,middle,bottom")]
      public function get scrollPositionVerticalAlign() : String
      {
         return this._scrollPositionVerticalAlign;
      }
      
      public function set scrollPositionVerticalAlign(param1:String) : void
      {
         this._scrollPositionVerticalAlign = param1;
      }
      
      public function get requiresLayoutOnScroll() : Boolean
      {
         return this._manageVisibility || this._useVirtualLayout;
      }
      
      public function layout(param1:Vector.<DisplayObject>, param2:ViewPortBounds = null, param3:LayoutBoundsResult = null) : LayoutBoundsResult
      {
         var _loc34_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc32_:int = 0;
         var _loc26_:* = null;
         var _loc13_:int = 0;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:* = NaN;
         var _loc7_:* = NaN;
         var _loc19_:* = NaN;
         var _loc6_:* = null;
         var _loc24_:* = null;
         var _loc10_:* = NaN;
         var _loc8_:* = null;
         var _loc42_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc46_:Number = !!param2?param2.scrollX:0;
         var _loc43_:Number = !!param2?param2.scrollY:0;
         var _loc38_:Number = !!param2?param2.x:0;
         var _loc41_:Number = !!param2?param2.y:0;
         var _loc33_:Number = !!param2?param2.minWidth:0;
         var _loc11_:Number = !!param2?param2.minHeight:0;
         var _loc22_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc15_:Number = !!param2?param2.maxHeight:Infinity;
         var _loc37_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc44_:Number = !!param2?param2.explicitHeight:NaN;
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem(_loc37_ - this._paddingLeft - this._paddingRight);
            _loc34_ = !!this._typicalItem?this._typicalItem.width:0;
            _loc30_ = !!this._typicalItem?this._typicalItem.height:0;
         }
         if(!this._useVirtualLayout || this._hasVariableItemDimensions || this._distributeHeights || this._horizontalAlign != "justify" || _loc37_ !== _loc37_)
         {
            this.validateItems(param1,_loc37_ - this._paddingLeft - this._paddingRight,_loc44_);
         }
         if(!this._useVirtualLayout)
         {
            this.applyPercentHeights(param1,_loc44_,_loc11_,_loc15_);
         }
         var _loc21_:Number = NaN;
         if(this._distributeHeights)
         {
            _loc21_ = this.calculateDistributedHeight(param1,_loc44_,_loc11_,_loc15_);
         }
         var _loc25_:* = _loc21_ === _loc21_;
         this._discoveredItemsCache.length = 0;
         var _loc9_:* = this._firstGap === this._firstGap;
         var _loc39_:* = this._lastGap === this._lastGap;
         var _loc45_:* = Number(!!this._useVirtualLayout?_loc34_:0);
         var _loc12_:Number = _loc41_ + this._paddingTop;
         var _loc40_:int = 0;
         var _loc35_:int = param1.length;
         var _loc36_:* = _loc35_;
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc36_ = int(_loc36_ + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount));
            _loc40_ = this._beforeVirtualizedItemCount;
            _loc12_ = _loc12_ + this._beforeVirtualizedItemCount * (_loc30_ + this._gap);
            if(_loc9_ && this._beforeVirtualizedItemCount > 0)
            {
               _loc12_ = _loc12_ - this._gap + this._firstGap;
            }
         }
         var _loc23_:int = _loc36_ - 2;
         var _loc14_:int = 0;
         _loc32_ = 0;
         while(_loc32_ < _loc35_)
         {
            _loc26_ = param1[_loc32_];
            _loc13_ = _loc32_ + _loc40_;
            _loc16_ = this._gap;
            if(_loc9_ && _loc13_ == 0)
            {
               _loc16_ = this._firstGap;
            }
            else if(_loc39_ && _loc13_ > 0 && _loc13_ == _loc23_)
            {
               _loc16_ = this._lastGap;
            }
            if(this._useVirtualLayout && this._hasVariableItemDimensions && _loc13_ < this._heightCache.length)
            {
               _loc17_ = this._heightCache[_loc13_];
            }
            if(this._useVirtualLayout && !_loc26_)
            {
               if(!this._hasVariableItemDimensions || _loc17_ !== _loc17_)
               {
                  _loc12_ = _loc12_ + (_loc30_ + _loc16_);
               }
               else
               {
                  _loc12_ = _loc12_ + (_loc17_ + _loc16_);
               }
            }
            else if(!(_loc26_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc26_).includeInLayout))
            {
               _loc26_.y = _loc26_.pivotY + _loc12_;
               _loc18_ = Number(_loc26_.width);
               if(_loc25_)
               {
                  _loc7_ = _loc21_;
                  _loc26_.height = _loc7_;
               }
               else
               {
                  _loc7_ = Number(_loc26_.height);
               }
               if(this._useVirtualLayout)
               {
                  if(this._hasVariableItemDimensions)
                  {
                     if(_loc7_ != _loc17_)
                     {
                        this._heightCache[_loc13_] = _loc7_;
                        this.dispatchEventWith("change");
                     }
                  }
                  else if(_loc30_ >= 0)
                  {
                     _loc7_ = _loc30_;
                     _loc26_.height = _loc7_;
                  }
               }
               _loc12_ = _loc12_ + (_loc7_ + _loc16_);
               if(_loc18_ > _loc45_)
               {
                  _loc45_ = _loc18_;
               }
               if(this._useVirtualLayout)
               {
                  this._discoveredItemsCache[_loc14_] = _loc26_;
                  _loc14_++;
               }
            }
            _loc32_++;
         }
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc12_ = _loc12_ + this._afterVirtualizedItemCount * (_loc30_ + this._gap);
            if(_loc39_ && this._afterVirtualizedItemCount > 0)
            {
               _loc12_ = _loc12_ - this._gap + this._lastGap;
            }
         }
         var _loc27_:Vector.<DisplayObject> = !!this._useVirtualLayout?this._discoveredItemsCache:param1;
         var _loc20_:Number = _loc45_ + this._paddingLeft + this._paddingRight;
         var _loc28_:* = _loc37_;
         if(_loc28_ !== _loc28_)
         {
            _loc28_ = _loc20_;
            if(_loc28_ < _loc33_)
            {
               _loc28_ = _loc33_;
            }
            else if(_loc28_ > _loc22_)
            {
               _loc28_ = _loc22_;
            }
         }
         var _loc29_:int = _loc27_.length;
         var _loc4_:Number = _loc12_ - this._gap + this._paddingBottom - _loc41_;
         var _loc5_:* = _loc44_;
         if(_loc5_ !== _loc5_)
         {
            _loc5_ = _loc4_;
            if(_loc5_ < _loc11_)
            {
               _loc5_ = _loc11_;
            }
            else if(_loc5_ > _loc15_)
            {
               _loc5_ = _loc15_;
            }
         }
         if(_loc4_ < _loc5_)
         {
            _loc19_ = 0;
            if(this._verticalAlign == "bottom")
            {
               _loc19_ = Number(_loc5_ - _loc4_);
            }
            else if(this._verticalAlign == "middle")
            {
               _loc19_ = Number(Math.round((_loc5_ - _loc4_) / 2));
            }
            if(_loc19_ != 0)
            {
               _loc32_ = 0;
               while(_loc32_ < _loc29_)
               {
                  _loc26_ = _loc27_[_loc32_];
                  if(!(_loc26_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc26_).includeInLayout))
                  {
                     _loc26_.y = _loc26_.y + _loc19_;
                  }
                  _loc32_++;
               }
            }
         }
         _loc32_ = 0;
         while(_loc32_ < _loc29_)
         {
            _loc26_ = _loc27_[_loc32_];
            if(!(_loc26_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc26_).includeInLayout))
            {
               _loc6_ = _loc26_ as ILayoutDisplayObject;
               if(this._horizontalAlign == "justify")
               {
                  _loc26_.x = _loc26_.pivotX + _loc38_ + this._paddingLeft;
                  _loc26_.width = _loc28_ - this._paddingLeft - this._paddingRight;
               }
               else
               {
                  if(_loc6_)
                  {
                     _loc24_ = _loc6_.layoutData as VerticalLayoutData;
                     if(_loc24_)
                     {
                        _loc10_ = Number(_loc24_.percentWidth);
                        if(_loc10_ === _loc10_)
                        {
                           if(_loc10_ < 0)
                           {
                              _loc10_ = 0;
                           }
                           if(_loc10_ > 100)
                           {
                              _loc10_ = 100;
                           }
                           _loc18_ = Number(_loc10_ * (_loc28_ - this._paddingLeft - this._paddingRight) / 100);
                           if(_loc26_ is IFeathersControl)
                           {
                              _loc8_ = IFeathersControl(_loc26_);
                              _loc42_ = _loc8_.minWidth;
                              if(_loc18_ < _loc42_)
                              {
                                 _loc18_ = _loc42_;
                              }
                              else
                              {
                                 _loc31_ = _loc8_.maxWidth;
                                 if(_loc18_ > _loc31_)
                                 {
                                    _loc18_ = _loc31_;
                                 }
                              }
                           }
                           _loc26_.width = _loc18_;
                        }
                     }
                  }
                  var _loc47_:* = this._horizontalAlign;
                  if("right" !== _loc47_)
                  {
                     if("center" !== _loc47_)
                     {
                        _loc26_.x = _loc26_.pivotX + _loc38_ + this._paddingLeft;
                     }
                     else
                     {
                        _loc26_.x = _loc26_.pivotX + _loc38_ + this._paddingLeft + Math.round((_loc28_ - this._paddingLeft - this._paddingRight - _loc26_.width) / 2);
                     }
                  }
                  else
                  {
                     _loc26_.x = _loc26_.pivotX + _loc38_ + _loc28_ - this._paddingRight - _loc26_.width;
                  }
               }
               if(this.manageVisibility)
               {
                  _loc26_.visible = _loc26_.y - _loc26_.pivotY + _loc26_.height >= _loc41_ + _loc43_ && _loc26_.y - _loc26_.pivotY < _loc43_ + _loc5_;
               }
            }
            _loc32_++;
         }
         this._discoveredItemsCache.length = 0;
         if(!param3)
         {
            param3 = new LayoutBoundsResult();
         }
         param3.contentWidth = this._horizontalAlign == "justify"?_loc28_:Number(_loc20_);
         param3.contentHeight = _loc4_;
         param3.viewPortWidth = _loc28_;
         param3.viewPortHeight = _loc5_;
         return param3;
      }
      
      public function measureViewPort(param1:int, param2:ViewPortBounds = null, param3:Point = null) : Point
      {
         var _loc14_:* = NaN;
         var _loc20_:* = NaN;
         var _loc6_:int = 0;
         var _loc17_:Number = NaN;
         var _loc11_:* = NaN;
         var _loc9_:* = NaN;
         if(!param3)
         {
            param3 = new Point();
         }
         if(!this._useVirtualLayout)
         {
            throw new IllegalOperationError("measureViewPort() may be called only if useVirtualLayout is true.");
         }
         var _loc12_:Number = !!param2?param2.explicitWidth:NaN;
         var _loc19_:Number = !!param2?param2.explicitHeight:NaN;
         var _loc4_:* = _loc12_ !== _loc12_;
         var _loc18_:* = _loc19_ !== _loc19_;
         if(!_loc4_ && !_loc18_)
         {
            param3.x = _loc12_;
            param3.y = _loc19_;
            return param3;
         }
         var _loc7_:Number = !!param2?param2.minWidth:0;
         var _loc13_:Number = !!param2?param2.minHeight:0;
         var _loc21_:Number = !!param2?param2.maxWidth:Infinity;
         var _loc16_:Number = !!param2?param2.maxHeight:Infinity;
         this.prepareTypicalItem(_loc12_ - this._paddingLeft - this._paddingRight);
         var _loc10_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc5_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc8_:* = this._firstGap === this._firstGap;
         var _loc15_:* = this._lastGap === this._lastGap;
         if(this._distributeHeights)
         {
            _loc14_ = Number((_loc5_ + this._gap) * param1);
         }
         else
         {
            _loc14_ = 0;
            _loc20_ = _loc10_;
            if(!this._hasVariableItemDimensions)
            {
               _loc14_ = Number(_loc14_ + (_loc5_ + this._gap) * param1);
            }
            else
            {
               _loc6_ = 0;
               while(_loc6_ < param1)
               {
                  _loc17_ = this._heightCache[_loc6_];
                  if(_loc17_ !== _loc17_)
                  {
                     _loc14_ = Number(_loc14_ + (_loc5_ + this._gap));
                  }
                  else
                  {
                     _loc14_ = Number(_loc14_ + (_loc17_ + this._gap));
                  }
                  _loc6_++;
               }
            }
         }
         _loc14_ = Number(_loc14_ - this._gap);
         if(_loc8_ && param1 > 1)
         {
            _loc14_ = Number(_loc14_ - this._gap + this._firstGap);
         }
         if(_loc15_ && param1 > 2)
         {
            _loc14_ = Number(_loc14_ - this._gap + this._lastGap);
         }
         if(_loc4_)
         {
            _loc11_ = Number(_loc20_ + this._paddingLeft + this._paddingRight);
            if(_loc11_ < _loc7_)
            {
               _loc11_ = _loc7_;
            }
            else if(_loc11_ > _loc21_)
            {
               _loc11_ = _loc21_;
            }
            param3.x = _loc11_;
         }
         else
         {
            param3.x = _loc12_;
         }
         if(_loc18_)
         {
            _loc9_ = Number(_loc14_ + this._paddingTop + this._paddingBottom);
            if(_loc9_ < _loc13_)
            {
               _loc9_ = _loc13_;
            }
            else if(_loc9_ > _loc16_)
            {
               _loc9_ = _loc16_;
            }
            param3.y = _loc9_;
         }
         else
         {
            param3.y = _loc19_;
         }
         return param3;
      }
      
      public function resetVariableVirtualCache() : void
      {
         this._heightCache.length = 0;
      }
      
      public function resetVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void
      {
         delete this._heightCache[param1];
         if(param2)
         {
            this._heightCache[param1] = param2.height;
            this.dispatchEventWith("change");
         }
      }
      
      public function addToVariableVirtualCacheAtIndex(param1:int, param2:DisplayObject = null) : void
      {
         var _loc3_:* = !!param2?param2.height:undefined;
         this._heightCache.splice(param1,0,_loc3_);
      }
      
      public function removeFromVariableVirtualCacheAtIndex(param1:int) : void
      {
         this._heightCache.splice(param1,1);
      }
      
      public function getVisibleIndicesAtScrollPosition(param1:Number, param2:Number, param3:Number, param4:Number, param5:int, param6:Vector.<int> = null) : Vector.<int>
      {
         var _loc27_:int = 0;
         var _loc14_:Number = NaN;
         var _loc30_:int = 0;
         var _loc28_:int = 0;
         var _loc24_:* = 0;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc8_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:int = 0;
         var _loc9_:int = 0;
         var _loc15_:int = 0;
         var _loc17_:* = 0;
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
         this.prepareTypicalItem(param3 - this._paddingLeft - this._paddingRight);
         var _loc25_:Number = !!this._typicalItem?this._typicalItem.width:0;
         var _loc22_:Number = !!this._typicalItem?this._typicalItem.height:0;
         var _loc10_:* = this._firstGap === this._firstGap;
         var _loc26_:* = this._lastGap === this._lastGap;
         var _loc7_:* = 0;
         var _loc16_:int = Math.ceil(param4 / (_loc22_ + this._gap));
         if(!this._hasVariableItemDimensions)
         {
            _loc27_ = 0;
            _loc14_ = param5 * (_loc22_ + this._gap) - this._gap;
            if(_loc10_ && param5 > 1)
            {
               _loc14_ = _loc14_ - this._gap + this._firstGap;
            }
            if(_loc26_ && param5 > 2)
            {
               _loc14_ = _loc14_ - this._gap + this._lastGap;
            }
            if(_loc14_ < param4)
            {
               if(this._verticalAlign == "bottom")
               {
                  _loc27_ = Math.ceil((param4 - _loc14_) / (_loc22_ + this._gap));
               }
               else if(this._verticalAlign == "middle")
               {
                  _loc27_ = Math.ceil((param4 - _loc14_) / (_loc22_ + this._gap) / 2);
               }
            }
            _loc30_ = (param2 - this._paddingTop) / (_loc22_ + this._gap);
            if(_loc30_ < 0)
            {
               _loc30_ = 0;
            }
            _loc30_ = _loc30_ - _loc27_;
            _loc28_ = _loc30_ + _loc16_;
            if(_loc28_ >= param5)
            {
               _loc28_ = param5 - 1;
            }
            _loc30_ = _loc28_ - _loc16_;
            if(_loc30_ < 0)
            {
               _loc30_ = 0;
            }
            _loc24_ = _loc30_;
            while(_loc24_ <= _loc28_)
            {
               param6[_loc7_] = _loc24_;
               _loc7_++;
               _loc24_++;
            }
            return param6;
         }
         var _loc20_:int = param5 - 2;
         var _loc21_:Number = param2 + param4;
         var _loc13_:Number = this._paddingTop;
         _loc24_ = 0;
         while(_loc24_ < param5)
         {
            _loc18_ = this._gap;
            if(_loc10_ && _loc24_ == 0)
            {
               _loc18_ = this._firstGap;
            }
            else if(_loc26_ && _loc24_ > 0 && _loc24_ == _loc20_)
            {
               _loc18_ = this._lastGap;
            }
            _loc19_ = this._heightCache[_loc24_];
            if(_loc19_ !== _loc19_)
            {
               _loc8_ = _loc22_;
            }
            else
            {
               _loc8_ = _loc19_;
            }
            _loc11_ = _loc13_;
            _loc13_ = _loc13_ + (_loc8_ + _loc18_);
            if(_loc13_ > param2 && _loc11_ < _loc21_)
            {
               param6[_loc7_] = _loc24_;
               _loc7_++;
            }
            if(_loc13_ < _loc21_)
            {
               _loc24_++;
               continue;
            }
            break;
         }
         var _loc29_:int = param6.length;
         var _loc23_:int = _loc16_ - _loc29_;
         if(_loc23_ > 0 && _loc29_ > 0)
         {
            _loc12_ = param6[0];
            _loc9_ = _loc12_ - _loc23_;
            if(_loc9_ < 0)
            {
               _loc9_ = 0;
            }
            _loc24_ = int(_loc12_ - 1);
            while(_loc24_ >= _loc9_)
            {
               param6.unshift(_loc24_);
               _loc24_--;
            }
         }
         _loc29_ = param6.length;
         _loc23_ = _loc16_ - _loc29_;
         _loc7_ = _loc29_;
         if(_loc23_ > 0)
         {
            _loc15_ = _loc29_ > 0?param6[_loc29_ - 1] + 1:0;
            _loc17_ = int(_loc15_ + _loc23_);
            if(_loc17_ > param5)
            {
               _loc17_ = param5;
            }
            _loc24_ = _loc15_;
            while(_loc24_ < _loc17_)
            {
               param6[_loc7_] = _loc24_;
               _loc7_++;
               _loc24_++;
            }
         }
         return param6;
      }
      
      public function getScrollPositionForIndex(param1:int, param2:Vector.<DisplayObject>, param3:Number, param4:Number, param5:Number, param6:Number, param7:Point = null) : Point
      {
         var _loc14_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc12_:int = 0;
         var _loc9_:* = null;
         var _loc19_:int = 0;
         var _loc22_:Number = NaN;
         var _loc11_:* = NaN;
         if(!param7)
         {
            param7 = new Point();
         }
         if(this._useVirtualLayout)
         {
            this.prepareTypicalItem(param5 - this._paddingLeft - this._paddingRight);
            _loc14_ = !!this._typicalItem?this._typicalItem.width:0;
            _loc10_ = !!this._typicalItem?this._typicalItem.height:0;
         }
         var _loc13_:* = this._firstGap === this._firstGap;
         var _loc20_:* = this._lastGap === this._lastGap;
         var _loc17_:Number = param4 + this._paddingTop;
         var _loc24_:* = 0;
         var _loc21_:Number = this._gap;
         var _loc18_:int = 0;
         var _loc23_:* = 0;
         var _loc15_:int = param2.length;
         var _loc16_:* = _loc15_;
         if(this._useVirtualLayout && !this._hasVariableItemDimensions)
         {
            _loc16_ = int(_loc16_ + (this._beforeVirtualizedItemCount + this._afterVirtualizedItemCount));
            if(param1 < this._beforeVirtualizedItemCount)
            {
               _loc18_ = param1 + 1;
               _loc24_ = _loc10_;
               _loc21_ = this._gap;
            }
            else
            {
               _loc18_ = this._beforeVirtualizedItemCount;
               _loc23_ = Number(param1 - param2.length - this._beforeVirtualizedItemCount + 1);
               if(_loc23_ < 0)
               {
                  _loc23_ = 0;
               }
               _loc17_ = _loc17_ + _loc23_ * (_loc10_ + this._gap);
            }
            _loc17_ = _loc17_ + _loc18_ * (_loc10_ + this._gap);
         }
         param1 = param1 - (_loc18_ + _loc23_);
         var _loc8_:int = _loc16_ - 2;
         _loc12_ = 0;
         while(_loc12_ <= param1)
         {
            _loc9_ = param2[_loc12_];
            _loc19_ = _loc12_ + _loc18_;
            if(_loc13_ && _loc19_ == 0)
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
            if(this._useVirtualLayout && this._hasVariableItemDimensions && _loc19_ < this._heightCache.length)
            {
               _loc22_ = this._heightCache[_loc19_];
            }
            if(this._useVirtualLayout && !_loc9_)
            {
               if(!this._hasVariableItemDimensions || _loc22_ !== _loc22_)
               {
                  _loc24_ = _loc10_;
               }
               else
               {
                  _loc24_ = _loc22_;
               }
            }
            else
            {
               _loc11_ = Number(_loc9_.height);
               if(this._useVirtualLayout)
               {
                  if(this._hasVariableItemDimensions)
                  {
                     if(_loc11_ != _loc22_)
                     {
                        this._heightCache[_loc19_] = _loc11_;
                        this.dispatchEventWith("change");
                     }
                  }
                  else if(_loc10_ >= 0)
                  {
                     _loc11_ = _loc10_;
                     _loc9_.height = _loc11_;
                  }
               }
               _loc24_ = _loc11_;
            }
            _loc17_ = _loc17_ + (_loc24_ + _loc21_);
            _loc12_++;
         }
         _loc17_ = _loc17_ - (_loc24_ + _loc21_);
         if(this._scrollPositionVerticalAlign == "middle")
         {
            _loc17_ = _loc17_ - Math.round((param6 - _loc24_) / 2);
         }
         else if(this._scrollPositionVerticalAlign == "bottom")
         {
            _loc17_ = _loc17_ - (param6 - _loc24_);
         }
         param7.x = 0;
         param7.y = _loc17_;
         return param7;
      }
      
      protected function validateItems(param1:Vector.<DisplayObject>, param2:Number, param3:Number) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:Boolean = this._horizontalAlign == "justify" && param2 === param2;
         var _loc7_:int = param1.length;
         _loc6_ = 0;
         while(_loc6_ < _loc7_)
         {
            _loc5_ = param1[_loc6_];
            if(!(!_loc5_ || _loc5_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc5_).includeInLayout))
            {
               if(_loc4_)
               {
                  _loc5_.width = param2;
               }
               if(this._distributeHeights)
               {
                  _loc5_.height = param3;
               }
               if(_loc5_ is IValidating)
               {
                  IValidating(_loc5_).validate();
               }
            }
            _loc6_++;
         }
      }
      
      protected function prepareTypicalItem(param1:Number) : void
      {
         if(!this._typicalItem)
         {
            return;
         }
         if(this._horizontalAlign == "justify" && param1 === param1)
         {
            this._typicalItem.width = param1;
         }
         else if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.width = this._typicalItemWidth;
         }
         if(this._resetTypicalItemDimensionsOnMeasure)
         {
            this._typicalItem.height = this._typicalItemHeight;
         }
         if(this._typicalItem is IValidating)
         {
            IValidating(this._typicalItem).validate();
         }
      }
      
      protected function calculateDistributedHeight(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:* = NaN;
         var _loc10_:int = 0;
         var _loc6_:* = null;
         var _loc9_:Number = NaN;
         var _loc8_:Boolean = false;
         var _loc11_:int = param1.length;
         if(param2 !== param2)
         {
            _loc5_ = 0;
            _loc10_ = 0;
            while(_loc10_ < _loc11_)
            {
               _loc6_ = param1[_loc10_];
               _loc9_ = _loc6_.height;
               if(_loc9_ > _loc5_)
               {
                  _loc5_ = _loc9_;
               }
               _loc10_++;
            }
            param2 = Number(_loc5_ * _loc11_ + this._paddingTop + this._paddingBottom + this._gap * (_loc11_ - 1));
            _loc8_ = false;
            if(param2 > param4)
            {
               param2 = param4;
               _loc8_ = true;
            }
            else if(param2 < param3)
            {
               param2 = param3;
               _loc8_ = true;
            }
            if(!_loc8_)
            {
               return _loc5_;
            }
         }
         var _loc7_:Number = param2 - this._paddingTop - this._paddingBottom - this._gap * (_loc11_ - 1);
         if(_loc11_ > 1 && this._firstGap === this._firstGap)
         {
            _loc7_ = _loc7_ + (this._gap - this._firstGap);
         }
         if(_loc11_ > 2 && this._lastGap === this._lastGap)
         {
            _loc7_ = _loc7_ + (this._gap - this._lastGap);
         }
         return _loc7_ / _loc11_;
      }
      
      protected function applyPercentHeights(param1:Vector.<DisplayObject>, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc10_:int = 0;
         var _loc7_:* = null;
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc17_:Number = NaN;
         var _loc11_:* = null;
         var _loc12_:Boolean = false;
         var _loc20_:Number = NaN;
         var _loc9_:* = NaN;
         var _loc21_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc5_:* = param2;
         this._discoveredItemsCache.length = 0;
         var _loc16_:* = 0;
         var _loc19_:* = 0;
         var _loc13_:* = 0;
         var _loc15_:int = param1.length;
         var _loc14_:int = 0;
         _loc10_ = 0;
         for(; _loc10_ < _loc15_; _loc10_++)
         {
            _loc7_ = param1[_loc10_];
            if(!(_loc7_ is ILayoutableDisplayObject && !ILayoutableDisplayObject(_loc7_).includeInLayout))
            {
               if(_loc7_ is ILayoutDisplayObject)
               {
                  _loc8_ = ILayoutDisplayObject(_loc7_);
                  _loc6_ = _loc8_.layoutData as VerticalLayoutData;
                  if(_loc6_)
                  {
                     _loc17_ = _loc6_.percentHeight;
                     if(_loc17_ === _loc17_)
                     {
                        if(_loc8_ is IFeathersControl)
                        {
                           _loc11_ = IFeathersControl(_loc8_);
                           _loc19_ = Number(_loc19_ + _loc11_.minHeight);
                        }
                        _loc13_ = Number(_loc13_ + _loc17_);
                        this._discoveredItemsCache[_loc14_] = _loc7_;
                        _loc14_++;
                        continue;
                     }
                  }
               }
               _loc16_ = Number(_loc16_ + _loc7_.height);
               continue;
            }
         }
         _loc16_ = Number(_loc16_ + this._gap * (_loc15_ - 1));
         if(this._firstGap === this._firstGap && _loc15_ > 1)
         {
            _loc16_ = Number(_loc16_ + (this._firstGap - this._gap));
         }
         else if(this._lastGap === this._lastGap && _loc15_ > 2)
         {
            _loc16_ = Number(_loc16_ + (this._lastGap - this._gap));
         }
         _loc16_ = Number(_loc16_ + (this._paddingTop + this._paddingBottom));
         if(_loc13_ < 100)
         {
            _loc13_ = 100;
         }
         if(_loc5_ !== _loc5_)
         {
            _loc5_ = Number(_loc16_ + _loc19_);
            if(_loc5_ < param3)
            {
               _loc5_ = param3;
            }
            else if(_loc5_ > param4)
            {
               _loc5_ = param4;
            }
         }
         _loc5_ = Number(_loc5_ - _loc16_);
         if(_loc5_ < 0)
         {
            _loc5_ = 0;
         }
         do
         {
            _loc12_ = false;
            _loc20_ = _loc5_ / _loc13_;
            _loc10_ = 0;
            while(_loc10_ < _loc14_)
            {
               _loc8_ = ILayoutDisplayObject(this._discoveredItemsCache[_loc10_]);
               if(_loc8_)
               {
                  _loc6_ = VerticalLayoutData(_loc8_.layoutData);
                  _loc17_ = _loc6_.percentHeight;
                  _loc9_ = Number(_loc20_ * _loc17_);
                  if(_loc8_ is IFeathersControl)
                  {
                     _loc11_ = IFeathersControl(_loc8_);
                     _loc21_ = _loc11_.minHeight;
                     if(_loc9_ < _loc21_)
                     {
                        _loc9_ = _loc21_;
                        _loc5_ = Number(_loc5_ - _loc9_);
                        _loc13_ = Number(_loc13_ - _loc17_);
                        this._discoveredItemsCache[_loc10_] = null;
                        _loc12_ = true;
                     }
                     else
                     {
                        _loc18_ = _loc11_.maxHeight;
                        if(_loc9_ > _loc18_)
                        {
                           _loc9_ = _loc18_;
                           _loc5_ = Number(_loc5_ - _loc9_);
                           _loc13_ = Number(_loc13_ - _loc17_);
                           this._discoveredItemsCache[_loc10_] = null;
                           _loc12_ = true;
                        }
                     }
                  }
                  _loc8_.height = _loc9_;
               }
               _loc10_++;
            }
         }
         while(_loc12_);
         
         this._discoveredItemsCache.length = 0;
      }
   }
}
