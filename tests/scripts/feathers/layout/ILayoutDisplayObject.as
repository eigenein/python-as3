package feathers.layout
{
   import feathers.core.IFeathersDisplayObject;
   
   [Event(name="layoutDataChange",type="starling.events.Event")]
   public interface ILayoutDisplayObject extends IFeathersDisplayObject, ILayoutableDisplayObject
   {
       
      
      function get layoutData() : ILayoutData;
      
      function set layoutData(param1:ILayoutData) : void;
   }
}
