package game.view.popup.hero
{
   import feathers.controls.Label;
   import starling.core.Starling;
   
   public class HeroPopupPowerAnimation
   {
       
      
      private var _tweenableValue:Number;
      
      private var value:int;
      
      private var label:Label;
      
      public function HeroPopupPowerAnimation(param1:Label)
      {
         super();
         this.label = param1;
      }
      
      public function get tweenableValue() : Number
      {
         return _tweenableValue;
      }
      
      public function set tweenableValue(param1:Number) : void
      {
         this._tweenableValue = param1;
         label.text = String(int(_tweenableValue));
      }
      
      public function setValueWithoutAnimation(param1:int) : void
      {
         label.text = String(param1);
         _tweenableValue = param1;
         this.value = param1;
      }
      
      public function setValue(param1:int) : void
      {
         label.text = String(this.value);
         this.value = param1;
         Starling.juggler.tween(this,1,{
            "transition":"linear",
            "tweenableValue":param1
         });
      }
   }
}
