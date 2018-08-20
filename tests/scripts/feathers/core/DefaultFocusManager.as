package feathers.core
{
   import feathers.controls.supportClasses.LayoutViewPort;
   import flash.display.InteractiveObject;
   import flash.display.Stage;
   import flash.events.FocusEvent;
   import flash.utils.Dictionary;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.events.Event;
   import starling.events.Touch;
   import starling.events.TouchEvent;
   
   public class DefaultFocusManager implements IFocusManager
   {
      
      protected static var NATIVE_STAGE_TO_FOCUS_TARGET:Dictionary = new Dictionary(true);
       
      
      protected var _starling:Starling;
      
      protected var _nativeFocusTarget:NativeFocusTarget;
      
      protected var _root:DisplayObjectContainer;
      
      protected var _isEnabled:Boolean = false;
      
      protected var _savedFocus:IFocusDisplayObject;
      
      protected var _focus:IFocusDisplayObject;
      
      public function DefaultFocusManager(param1:DisplayObjectContainer)
      {
         super();
         if(!param1.stage)
         {
            throw new ArgumentError("Focus manager root must be added to the stage.");
         }
         this._root = param1;
         var _loc4_:int = 0;
         var _loc3_:* = Starling.all;
         for each(var _loc2_ in Starling.all)
         {
            if(_loc2_.stage == param1.stage)
            {
               this._starling = _loc2_;
               break;
            }
         }
         this.setFocusManager(this._root);
      }
      
      public function get root() : DisplayObjectContainer
      {
         return this._root;
      }
      
      public function get isEnabled() : Boolean
      {
         return this._isEnabled;
      }
      
      public function set isEnabled(param1:Boolean) : void
      {
         var _loc2_:* = null;
         if(this._isEnabled == param1)
         {
            return;
         }
         this._isEnabled = param1;
         if(this._isEnabled)
         {
            this._nativeFocusTarget = NATIVE_STAGE_TO_FOCUS_TARGET[this._starling.nativeStage] as NativeFocusTarget;
            if(!this._nativeFocusTarget)
            {
               this._nativeFocusTarget = new NativeFocusTarget();
               this._starling.nativeOverlay.addChild(_nativeFocusTarget);
            }
            else
            {
               this._nativeFocusTarget.referenceCount++;
            }
            this._root.addEventListener("added",topLevelContainer_addedHandler);
            this._root.addEventListener("removed",topLevelContainer_removedHandler);
            this._root.addEventListener("touch",topLevelContainer_touchHandler);
            this._starling.nativeStage.addEventListener("keyFocusChange",stage_keyFocusChangeHandler,false,0,true);
            this._starling.nativeStage.addEventListener("mouseFocusChange",stage_mouseFocusChangeHandler,false,0,true);
            this.focus = this._savedFocus;
            this._savedFocus = null;
         }
         else
         {
            this._nativeFocusTarget.referenceCount--;
            if(this._nativeFocusTarget.referenceCount <= 0)
            {
               this._nativeFocusTarget.parent.removeChild(this._nativeFocusTarget);
               delete NATIVE_STAGE_TO_FOCUS_TARGET[this._starling.nativeStage];
            }
            this._nativeFocusTarget = null;
            this._root.removeEventListener("added",topLevelContainer_addedHandler);
            this._root.removeEventListener("removed",topLevelContainer_removedHandler);
            this._root.removeEventListener("touch",topLevelContainer_touchHandler);
            this._starling.nativeStage.removeEventListener("keyFocusChange",stage_keyFocusChangeHandler);
            this._starling.nativeStage.addEventListener("mouseFocusChange",stage_mouseFocusChangeHandler);
            _loc2_ = this.focus;
            this.focus = null;
            this._savedFocus = _loc2_;
         }
      }
      
      public function get focus() : IFocusDisplayObject
      {
         return this._focus;
      }
      
      public function set focus(param1:IFocusDisplayObject) : void
      {
         var _loc2_:* = null;
         if(this._focus == param1)
         {
            return;
         }
         var _loc3_:IFeathersDisplayObject = this._focus;
         if(this._isEnabled && param1 && param1.isFocusEnabled && param1.focusManager == this)
         {
            this._focus = param1;
         }
         else
         {
            this._focus = null;
         }
         if(_loc3_)
         {
            _loc3_.dispatchEventWith("focusOut");
         }
         if(this._isEnabled)
         {
            _loc2_ = this._starling.nativeStage;
            if(this._focus)
            {
               if(!_loc2_.focus)
               {
                  _loc2_.focus = this._nativeFocusTarget;
               }
               _loc2_.focus.addEventListener("focusOut",nativeFocus_focusOutHandler,false,0,true);
               this._focus.dispatchEventWith("focusIn");
            }
            else
            {
               _loc2_.focus = null;
            }
         }
         else
         {
            this._savedFocus = param1;
         }
      }
      
      protected function setFocusManager(param1:DisplayObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = undefined;
         if(param1 is IFocusDisplayObject)
         {
            _loc3_ = IFocusDisplayObject(param1);
            _loc3_.focusManager = this;
         }
         else if(param1 is DisplayObjectContainer)
         {
            _loc2_ = DisplayObjectContainer(param1);
            _loc6_ = _loc2_.numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = _loc2_.getChildAt(_loc4_);
               this.setFocusManager(_loc8_);
               _loc4_++;
            }
            if(_loc2_ is IFocusExtras)
            {
               _loc7_ = IFocusExtras(_loc2_);
               _loc5_ = _loc7_.focusExtrasBefore;
               if(_loc5_)
               {
                  _loc6_ = _loc5_.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_)
                  {
                     _loc8_ = _loc5_[_loc4_];
                     this.setFocusManager(_loc8_);
                     _loc4_++;
                  }
               }
               _loc5_ = _loc7_.focusExtrasAfter;
               if(_loc5_)
               {
                  _loc6_ = _loc5_.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_)
                  {
                     _loc8_ = _loc5_[_loc4_];
                     this.setFocusManager(_loc8_);
                     _loc4_++;
                  }
               }
            }
         }
      }
      
      protected function clearFocusManager(param1:DisplayObject) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc4_:int = 0;
         var _loc8_:* = null;
         var _loc7_:* = null;
         var _loc5_:* = undefined;
         if(param1 is IFocusDisplayObject)
         {
            _loc3_ = IFocusDisplayObject(param1);
            if(_loc3_.focusManager == this)
            {
               if(this._focus == _loc3_)
               {
                  this.focus = _loc3_.focusOwner;
               }
               _loc3_.focusManager = null;
            }
         }
         if(param1 is DisplayObjectContainer)
         {
            _loc2_ = DisplayObjectContainer(param1);
            _loc6_ = _loc2_.numChildren;
            _loc4_ = 0;
            while(_loc4_ < _loc6_)
            {
               _loc8_ = _loc2_.getChildAt(_loc4_);
               this.clearFocusManager(_loc8_);
               _loc4_++;
            }
            if(_loc2_ is IFocusExtras)
            {
               _loc7_ = IFocusExtras(_loc2_);
               _loc5_ = _loc7_.focusExtrasBefore;
               if(_loc5_)
               {
                  _loc6_ = _loc5_.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_)
                  {
                     _loc8_ = _loc5_[_loc4_];
                     this.clearFocusManager(_loc8_);
                     _loc4_++;
                  }
               }
               _loc5_ = _loc7_.focusExtrasAfter;
               if(_loc5_)
               {
                  _loc6_ = _loc5_.length;
                  _loc4_ = 0;
                  while(_loc4_ < _loc6_)
                  {
                     _loc8_ = _loc5_[_loc4_];
                     this.clearFocusManager(_loc8_);
                     _loc4_++;
                  }
               }
            }
         }
      }
      
      protected function findPreviousFocus(param1:DisplayObjectContainer, param2:DisplayObject = null) : IFocusDisplayObject
      {
         var _loc4_:* = null;
         var _loc7_:* = undefined;
         var _loc9_:* = false;
         var _loc6_:int = 0;
         var _loc8_:* = 0;
         var _loc10_:* = null;
         var _loc5_:* = null;
         if(param1 is LayoutViewPort)
         {
            param1 = param1.parent;
         }
         var _loc3_:* = param2 == null;
         if(param1 is IFocusExtras)
         {
            _loc4_ = IFocusExtras(param1);
            _loc7_ = _loc4_.focusExtrasAfter;
            if(_loc7_)
            {
               _loc9_ = false;
               if(param2)
               {
                  _loc6_ = _loc7_.indexOf(param2) - 1;
                  _loc3_ = _loc6_ >= -1;
                  _loc9_ = !_loc3_;
               }
               else
               {
                  _loc6_ = _loc7_.length - 1;
               }
               if(!_loc9_)
               {
                  _loc8_ = _loc6_;
                  while(_loc8_ >= 0)
                  {
                     _loc10_ = _loc7_[_loc8_];
                     _loc5_ = this.findPreviousChildFocus(_loc10_);
                     if(this.isValidFocus(_loc5_))
                     {
                        return _loc5_;
                     }
                     _loc8_--;
                  }
               }
            }
         }
         if(param2 && !_loc3_)
         {
            _loc6_ = param1.getChildIndex(param2) - 1;
            _loc3_ = _loc6_ >= -1;
         }
         else
         {
            _loc6_ = param1.numChildren - 1;
         }
         _loc8_ = _loc6_;
         while(_loc8_ >= 0)
         {
            _loc10_ = param1.getChildAt(_loc8_);
            _loc5_ = this.findPreviousChildFocus(_loc10_);
            if(this.isValidFocus(_loc5_))
            {
               return _loc5_;
            }
            _loc8_--;
         }
         if(param1 is IFocusExtras)
         {
            _loc7_ = _loc4_.focusExtrasBefore;
            if(_loc7_)
            {
               _loc9_ = false;
               if(param2 && !_loc3_)
               {
                  _loc6_ = _loc7_.indexOf(param2) - 1;
                  _loc3_ = _loc6_ >= -1;
                  _loc9_ = !_loc3_;
               }
               else
               {
                  _loc6_ = _loc7_.length - 1;
               }
               if(!_loc9_)
               {
                  _loc8_ = _loc6_;
                  while(_loc8_ >= 0)
                  {
                     _loc10_ = _loc7_[_loc8_];
                     _loc5_ = this.findPreviousChildFocus(_loc10_);
                     if(this.isValidFocus(_loc5_))
                     {
                        return _loc5_;
                     }
                     _loc8_--;
                  }
               }
            }
         }
         if(param2 && param1 != this._root)
         {
            return this.findPreviousFocus(param1.parent,param1);
         }
         return null;
      }
      
      protected function findNextFocus(param1:DisplayObjectContainer, param2:DisplayObject = null) : IFocusDisplayObject
      {
         var _loc3_:* = null;
         var _loc7_:* = undefined;
         var _loc9_:* = false;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc8_:* = 0;
         var _loc11_:* = null;
         var _loc4_:* = null;
         if(param1 is LayoutViewPort)
         {
            param1 = param1.parent;
         }
         var _loc6_:* = param2 == null;
         if(param1 is IFocusExtras)
         {
            _loc3_ = IFocusExtras(param1);
            _loc7_ = _loc3_.focusExtrasBefore;
            if(_loc7_)
            {
               _loc9_ = false;
               if(param2)
               {
                  _loc5_ = _loc7_.indexOf(param2) + 1;
                  _loc6_ = _loc5_ > 0;
                  _loc9_ = !_loc6_;
               }
               else
               {
                  _loc5_ = 0;
               }
               if(!_loc9_)
               {
                  _loc10_ = _loc7_.length;
                  _loc8_ = _loc5_;
                  while(_loc8_ < _loc10_)
                  {
                     _loc11_ = _loc7_[_loc8_];
                     _loc4_ = this.findNextChildFocus(_loc11_);
                     if(this.isValidFocus(_loc4_))
                     {
                        return _loc4_;
                     }
                     _loc8_++;
                  }
               }
            }
         }
         if(param2 && !_loc6_)
         {
            _loc5_ = param1.getChildIndex(param2) + 1;
            _loc6_ = _loc5_ > 0;
         }
         else
         {
            _loc5_ = 0;
         }
         _loc10_ = param1.numChildren;
         _loc8_ = _loc5_;
         while(_loc8_ < _loc10_)
         {
            _loc11_ = param1.getChildAt(_loc8_);
            _loc4_ = this.findNextChildFocus(_loc11_);
            if(this.isValidFocus(_loc4_))
            {
               return _loc4_;
            }
            _loc8_++;
         }
         if(param1 is IFocusExtras)
         {
            _loc7_ = _loc3_.focusExtrasAfter;
            if(_loc7_)
            {
               _loc9_ = false;
               if(param2 && !_loc6_)
               {
                  _loc5_ = _loc7_.indexOf(param2) + 1;
                  _loc6_ = _loc5_ > 0;
                  _loc9_ = !_loc6_;
               }
               else
               {
                  _loc5_ = 0;
               }
               if(!_loc9_)
               {
                  _loc10_ = _loc7_.length;
                  _loc8_ = _loc5_;
                  while(_loc8_ < _loc10_)
                  {
                     _loc11_ = _loc7_[_loc8_];
                     _loc4_ = this.findNextChildFocus(_loc11_);
                     if(this.isValidFocus(_loc4_))
                     {
                        return _loc4_;
                     }
                     _loc8_++;
                  }
               }
            }
         }
         if(param2 && param1 != this._root)
         {
            return this.findNextFocus(param1.parent,param1);
         }
         return null;
      }
      
      protected function findPreviousChildFocus(param1:DisplayObject) : IFocusDisplayObject
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(param1 is IFocusDisplayObject)
         {
            _loc3_ = IFocusDisplayObject(param1);
            if(this.isValidFocus(_loc3_))
            {
               return _loc3_;
            }
         }
         else if(param1 is DisplayObjectContainer)
         {
            _loc4_ = DisplayObjectContainer(param1);
            _loc2_ = this.findPreviousFocus(_loc4_);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function findNextChildFocus(param1:DisplayObject) : IFocusDisplayObject
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc2_:* = null;
         if(param1 is IFocusDisplayObject)
         {
            _loc3_ = IFocusDisplayObject(param1);
            if(this.isValidFocus(_loc3_))
            {
               return _loc3_;
            }
         }
         else if(param1 is DisplayObjectContainer)
         {
            _loc4_ = DisplayObjectContainer(param1);
            _loc2_ = this.findNextFocus(_loc4_);
            if(_loc2_)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      protected function isValidFocus(param1:IFocusDisplayObject) : Boolean
      {
         if(!param1 || !param1.isFocusEnabled || param1.focusManager != this)
         {
            return false;
         }
         var _loc2_:IFeathersControl = param1 as IFeathersControl;
         if(_loc2_ && !_loc2_.isEnabled)
         {
            return false;
         }
         return true;
      }
      
      protected function stage_mouseFocusChangeHandler(param1:FocusEvent) : void
      {
         param1.preventDefault();
      }
      
      protected function stage_keyFocusChangeHandler(param1:FocusEvent) : void
      {
         if(param1.keyCode != 9 && param1.keyCode != 0)
         {
            return;
         }
         var _loc3_:IFocusDisplayObject = null;
         var _loc2_:IFocusDisplayObject = this._focus;
         if(_loc2_ && _loc2_.focusOwner)
         {
            _loc3_ = _loc2_.focusOwner;
         }
         else if(param1.shiftKey)
         {
            if(_loc2_)
            {
               if(_loc2_.previousTabFocus)
               {
                  _loc3_ = _loc2_.previousTabFocus;
               }
               else
               {
                  _loc3_ = this.findPreviousFocus(_loc2_.parent,DisplayObject(_loc2_));
               }
            }
            if(!_loc3_)
            {
               _loc3_ = this.findPreviousFocus(this._root);
            }
         }
         else
         {
            if(_loc2_)
            {
               if(_loc2_.nextTabFocus)
               {
                  _loc3_ = _loc2_.nextTabFocus;
               }
               else
               {
                  _loc3_ = this.findNextFocus(_loc2_.parent,DisplayObject(_loc2_));
               }
            }
            if(!_loc3_)
            {
               _loc3_ = this.findNextFocus(this._root);
            }
         }
         if(_loc3_)
         {
            param1.preventDefault();
         }
         this.focus = _loc3_;
         if(this._focus)
         {
            this._focus.showFocus();
         }
      }
      
      protected function topLevelContainer_addedHandler(param1:Event) : void
      {
         this.setFocusManager(DisplayObject(param1.target));
      }
      
      protected function topLevelContainer_removedHandler(param1:Event) : void
      {
         this.clearFocusManager(DisplayObject(param1.target));
      }
      
      protected function topLevelContainer_touchHandler(param1:TouchEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:Touch = param1.getTouch(this._root,"began");
         if(!_loc3_)
         {
            return;
         }
         var _loc4_:* = null;
         var _loc5_:DisplayObject = _loc3_.target;
         do
         {
            if(_loc5_ is IFocusDisplayObject)
            {
               _loc2_ = IFocusDisplayObject(_loc5_);
               if(this.isValidFocus(_loc2_))
               {
                  _loc4_ = _loc2_;
               }
            }
            _loc5_ = _loc5_.parent;
         }
         while(_loc5_);
         
         this.focus = _loc4_;
      }
      
      protected function nativeFocus_focusOutHandler(param1:FocusEvent) : void
      {
         var _loc3_:InteractiveObject = InteractiveObject(param1.currentTarget);
         var _loc2_:Stage = this._starling.nativeStage;
         if(this._focus && !_loc2_.focus)
         {
            _loc2_.focus = this._nativeFocusTarget;
         }
         if(_loc3_ != _loc2_.focus)
         {
            _loc3_.removeEventListener("focusOut",nativeFocus_focusOutHandler);
         }
      }
   }
}

import flash.display.Sprite;

class NativeFocusTarget extends Sprite
{
    
   
   public var referenceCount:int = 1;
   
   function NativeFocusTarget()
   {
      super();
      this.tabEnabled = true;
      this.mouseEnabled = false;
      this.mouseChildren = false;
      this.alpha = 0;
   }
}
