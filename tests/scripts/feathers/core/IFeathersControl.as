package feathers.core
{
   import feathers.skins.IStyleProvider;
   import flash.geom.Rectangle;
   
   [Event(name="initialize",type="starling.events.Event")]
   [Event(name="creationComplete",type="starling.events.Event")]
   [Event(name="resize",type="starling.events.Event")]
   public interface IFeathersControl extends IValidating
   {
       
      
      function get minWidth() : Number;
      
      function set minWidth(param1:Number) : void;
      
      function get minHeight() : Number;
      
      function set minHeight(param1:Number) : void;
      
      function get maxWidth() : Number;
      
      function set maxWidth(param1:Number) : void;
      
      function get maxHeight() : Number;
      
      function set maxHeight(param1:Number) : void;
      
      function get clipRect() : Rectangle;
      
      function set clipRect(param1:Rectangle) : void;
      
      function get isEnabled() : Boolean;
      
      function set isEnabled(param1:Boolean) : void;
      
      function get isInitialized() : Boolean;
      
      function get isCreated() : Boolean;
      
      function get nameList() : TokenList;
      
      function get styleNameList() : TokenList;
      
      function get styleName() : String;
      
      function set styleName(param1:String) : void;
      
      function get styleProvider() : IStyleProvider;
      
      function set styleProvider(param1:IStyleProvider) : void;
      
      function setSize(param1:Number, param2:Number) : void;
   }
}
