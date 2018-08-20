package feathers.core
{
   import flash.geom.Point;
   
   public interface ITextRenderer extends IFeathersControl, ITextBaselineControl
   {
       
      
      function get text() : String;
      
      function set text(param1:String) : void;
      
      function get wordWrap() : Boolean;
      
      function set wordWrap(param1:Boolean) : void;
      
      function measureText(param1:Point = null) : Point;
   }
}
