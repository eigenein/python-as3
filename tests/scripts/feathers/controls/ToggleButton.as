package feathers.controls
{
   import feathers.core.IToggle;
   import feathers.core.PropertyProxy;
   import feathers.skins.IStyleProvider;
   import starling.display.DisplayObject;
   
   [Event(name="change",type="starling.events.Event")]
   public class ToggleButton extends Button implements IToggle
   {
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      protected var _isToggle:Boolean = true;
      
      protected var _isSelected:Boolean = false;
      
      public function ToggleButton()
      {
         super();
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         if(ToggleButton.globalStyleProvider)
         {
            return ToggleButton.globalStyleProvider;
         }
         return Button.globalStyleProvider;
      }
      
      public function get isToggle() : Boolean
      {
         return this._isToggle;
      }
      
      public function set isToggle(param1:Boolean) : void
      {
         this._isToggle = param1;
      }
      
      public function get isSelected() : Boolean
      {
         return this._isSelected;
      }
      
      public function set isSelected(param1:Boolean) : void
      {
         if(this._isSelected == param1)
         {
            return;
         }
         this._isSelected = param1;
         this.invalidate("selected");
         this.invalidate("state");
         this.dispatchEventWith("change");
      }
      
      public function get defaultSelectedSkin() : DisplayObject
      {
         return DisplayObject(this._skinSelector.defaultSelectedValue);
      }
      
      public function set defaultSelectedSkin(param1:DisplayObject) : void
      {
         if(this._skinSelector.defaultSelectedValue == param1)
         {
            return;
         }
         this._skinSelector.defaultSelectedValue = param1;
         this.invalidate("styles");
      }
      
      public function get selectedUpSkin() : DisplayObject
      {
         return DisplayObject(this._skinSelector.getValueForState("up",true));
      }
      
      public function set selectedUpSkin(param1:DisplayObject) : void
      {
         if(this._skinSelector.getValueForState("up",true) == param1)
         {
            return;
         }
         this._skinSelector.setValueForState(param1,"up",true);
         this.invalidate("styles");
      }
      
      public function get selectedDownSkin() : DisplayObject
      {
         return DisplayObject(this._skinSelector.getValueForState("down",true));
      }
      
      public function set selectedDownSkin(param1:DisplayObject) : void
      {
         if(this._skinSelector.getValueForState("down",true) == param1)
         {
            return;
         }
         this._skinSelector.setValueForState(param1,"down",true);
         this.invalidate("styles");
      }
      
      public function get selectedHoverSkin() : DisplayObject
      {
         return DisplayObject(this._skinSelector.getValueForState("hover",true));
      }
      
      public function set selectedHoverSkin(param1:DisplayObject) : void
      {
         if(this._skinSelector.getValueForState("hover",true) == param1)
         {
            return;
         }
         this._skinSelector.setValueForState(param1,"hover",true);
         this.invalidate("styles");
      }
      
      public function get selectedDisabledSkin() : DisplayObject
      {
         return DisplayObject(this._skinSelector.getValueForState("disabled",true));
      }
      
      public function set selectedDisabledSkin(param1:DisplayObject) : void
      {
         if(this._skinSelector.getValueForState("disabled",true) == param1)
         {
            return;
         }
         this._skinSelector.setValueForState(param1,"disabled",true);
         this.invalidate("styles");
      }
      
      public function get defaultSelectedLabelProperties() : Object
      {
         var _loc1_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.defaultSelectedValue);
         if(!_loc1_)
         {
            _loc1_ = PropertyProxy.fromEmpty(childProperties_onChange);
            this._labelPropertiesSelector.defaultSelectedValue = _loc1_;
         }
         return _loc1_;
      }
      
      public function set defaultSelectedLabelProperties(param1:Object) : void
      {
         if(!PropertyProxy.isInstance(param1))
         {
            param1 = PropertyProxy.fromObject(param1);
         }
         var _loc2_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.defaultSelectedValue);
         if(_loc2_)
         {
            _loc2_.removeOnChangeCallback(childProperties_onChange);
         }
         this._labelPropertiesSelector.defaultSelectedValue = param1;
         if(param1)
         {
            PropertyProxy.asInstance(param1).addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get selectedUpLabelProperties() : Object
      {
         var _loc1_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("up",true));
         if(!_loc1_)
         {
            _loc1_ = PropertyProxy.fromEmpty(childProperties_onChange);
            this._labelPropertiesSelector.setValueForState(_loc1_,"up",true);
         }
         return _loc1_;
      }
      
      public function set selectedUpLabelProperties(param1:Object) : void
      {
         if(!PropertyProxy.isInstance(param1))
         {
            param1 = PropertyProxy.fromObject(param1);
         }
         var _loc2_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("up",true));
         if(_loc2_)
         {
            _loc2_.removeOnChangeCallback(childProperties_onChange);
         }
         this._labelPropertiesSelector.setValueForState(param1,"up",true);
         if(param1)
         {
            PropertyProxy.asInstance(param1).addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get selectedDownLabelProperties() : Object
      {
         var _loc1_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("down",true));
         if(!_loc1_)
         {
            _loc1_ = PropertyProxy.fromEmpty(childProperties_onChange);
            this._labelPropertiesSelector.setValueForState(_loc1_,"down",true);
         }
         return _loc1_;
      }
      
      public function set selectedDownLabelProperties(param1:Object) : void
      {
         if(!PropertyProxy.isInstance(param1))
         {
            param1 = PropertyProxy.fromObject(param1);
         }
         var _loc2_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("down",true));
         if(_loc2_)
         {
            _loc2_.removeOnChangeCallback(childProperties_onChange);
         }
         this._labelPropertiesSelector.setValueForState(param1,"down",true);
         if(param1)
         {
            PropertyProxy.asInstance(param1).addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get selectedHoverLabelProperties() : Object
      {
         var _loc1_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("hover",true));
         if(!_loc1_)
         {
            _loc1_ = PropertyProxy.fromEmpty(childProperties_onChange);
            this._labelPropertiesSelector.setValueForState(_loc1_,"hover",true);
         }
         return _loc1_;
      }
      
      public function set selectedHoverLabelProperties(param1:Object) : void
      {
         if(!PropertyProxy.isInstance(param1))
         {
            param1 = PropertyProxy.fromObject(param1);
         }
         var _loc2_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("hover",true));
         if(_loc2_)
         {
            _loc2_.removeOnChangeCallback(childProperties_onChange);
         }
         this._labelPropertiesSelector.setValueForState(param1,"hover",true);
         if(param1)
         {
            PropertyProxy.asInstance(param1).addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get selectedDisabledLabelProperties() : Object
      {
         var _loc1_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("disabled",true));
         if(!_loc1_)
         {
            _loc1_ = PropertyProxy.fromEmpty(childProperties_onChange);
            this._labelPropertiesSelector.setValueForState(_loc1_,"disabled",true);
         }
         return _loc1_;
      }
      
      public function set selectedDisabledLabelProperties(param1:Object) : void
      {
         if(!PropertyProxy.isInstance(param1))
         {
            param1 = PropertyProxy.fromObject(param1);
         }
         var _loc2_:PropertyProxy = PropertyProxy.asInstance(this._labelPropertiesSelector.getValueForState("disabled",true));
         if(_loc2_)
         {
            _loc2_.removeOnChangeCallback(childProperties_onChange);
         }
         this._labelPropertiesSelector.setValueForState(param1,"disabled",true);
         if(param1)
         {
            PropertyProxy.asInstance(param1).addOnChangeCallback(childProperties_onChange);
         }
         this.invalidate("styles");
      }
      
      public function get defaultSelectedIcon() : DisplayObject
      {
         return DisplayObject(this._iconSelector.defaultSelectedValue);
      }
      
      public function set defaultSelectedIcon(param1:DisplayObject) : void
      {
         if(this._iconSelector.defaultSelectedValue == param1)
         {
            return;
         }
         this._iconSelector.defaultSelectedValue = param1;
         this.invalidate("styles");
      }
      
      public function get selectedUpIcon() : DisplayObject
      {
         return DisplayObject(this._iconSelector.getValueForState("up",true));
      }
      
      public function set selectedUpIcon(param1:DisplayObject) : void
      {
         if(this._iconSelector.getValueForState("up",true) == param1)
         {
            return;
         }
         this._iconSelector.setValueForState(param1,"up",true);
         this.invalidate("styles");
      }
      
      public function get selectedDownIcon() : DisplayObject
      {
         return DisplayObject(this._iconSelector.getValueForState("down",true));
      }
      
      public function set selectedDownIcon(param1:DisplayObject) : void
      {
         if(this._iconSelector.getValueForState("down",true) == param1)
         {
            return;
         }
         this._iconSelector.setValueForState(param1,"down",true);
         this.invalidate("styles");
      }
      
      public function get selectedHoverIcon() : DisplayObject
      {
         return DisplayObject(this._iconSelector.getValueForState("hover",true));
      }
      
      public function set selectedHoverIcon(param1:DisplayObject) : void
      {
         if(this._iconSelector.getValueForState("hover",true) == param1)
         {
            return;
         }
         this._iconSelector.setValueForState(param1,"hover",true);
         this.invalidate("styles");
      }
      
      public function get selectedDisabledIcon() : DisplayObject
      {
         return DisplayObject(this._iconSelector.getValueForState("disabled",true));
      }
      
      public function set selectedDisabledIcon(param1:DisplayObject) : void
      {
         if(this._iconSelector.getValueForState("disabled",true) == param1)
         {
            return;
         }
         this._iconSelector.setValueForState(param1,"disabled",true);
         this.invalidate("styles");
      }
      
      override protected function trigger() : void
      {
         super.trigger();
         if(this._isToggle)
         {
            this.isSelected = !this._isSelected;
         }
      }
   }
}
