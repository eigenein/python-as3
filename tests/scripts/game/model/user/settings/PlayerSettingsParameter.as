package game.model.user.settings
{
   import avmplus.getQualifiedClassName;
   import game.model.GameModel;
   import idv.cjcat.signals.Signal;
   
   public class PlayerSettingsParameter
   {
       
      
      private var name:String;
      
      private var Type:Class;
      
      private var defaultValue;
      
      private var syncronizedValue;
      
      private var value;
      
      private var _onChanged:Signal;
      
      public function PlayerSettingsParameter(param1:String, param2:Class, param3:* = null)
      {
         super();
         _onChanged = new Signal(param2);
         this.name = param1;
         this.Type = param2;
         var _loc4_:* = param3;
         this.value = _loc4_;
         this.defaultValue = _loc4_;
      }
      
      public function get onChanged() : Signal
      {
         return _onChanged;
      }
      
      function syncronize(param1:*) : void
      {
         if(!checkType(param1))
         {
            return;
         }
         syncronizedValue = param1;
         param1 = param1 != null?param1:defaultValue;
         if(this.value != param1)
         {
            internalSetValue(param1);
         }
      }
      
      function syncronizeFromObject(param1:*) : void
      {
         var _loc2_:* = param1[name];
         if(!checkType(_loc2_))
         {
            return;
         }
         syncronizedValue = _loc2_;
         _loc2_ = _loc2_ != null?_loc2_:defaultValue;
         if(this.value != _loc2_)
         {
            internalSetValue(_loc2_);
         }
      }
      
      public function setValue(param1:*) : void
      {
         param1 = param1 != null?param1:defaultValue;
         if(this.value != param1)
         {
            if(!checkType(param1))
            {
               return;
            }
            internalSetValue(param1);
            GameModel.instance.actionManager.playerCommands.changeSettingsParameter(this);
         }
      }
      
      public function getValue() : *
      {
         return value;
      }
      
      public function getRawObject() : *
      {
         var _loc1_:Object = {};
         _loc1_[name] = value;
         return _loc1_;
      }
      
      public function setValueClientSide(param1:*) : void
      {
         if(!checkType(param1))
         {
            return;
         }
         internalSetValue(param1);
      }
      
      public function getName() : String
      {
         return name;
      }
      
      private function checkType(param1:*) : Boolean
      {
         if(param1 as Type == param1)
         {
            return true;
         }
         trace(getQualifiedClassName(this),"Wrong player setting value type for parameter " + name + ":" + Type + " was used value `" + param1 + "`");
         return false;
      }
      
      private function internalSetValue(param1:*) : void
      {
         this.value = param1;
         _onChanged.dispatch(this.value);
      }
   }
}
