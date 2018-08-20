package feathers.controls
{
   import feathers.skins.IStyleProvider;
   import flash.errors.IllegalOperationError;
   
   [Exclude(kind="property",name="isToggle")]
   public class Check extends ToggleButton
   {
      
      public static var globalStyleProvider:IStyleProvider;
       
      
      public function Check()
      {
         super();
         .super.isToggle = true;
      }
      
      override protected function get defaultStyleProvider() : IStyleProvider
      {
         return Check.globalStyleProvider;
      }
      
      override public function set isToggle(param1:Boolean) : void
      {
         throw IllegalOperationError("CheckBox isToggle must always be true.");
      }
   }
}
