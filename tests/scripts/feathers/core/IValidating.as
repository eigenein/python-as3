package feathers.core
{
   public interface IValidating extends IFeathersDisplayObject
   {
       
      
      function get depth() : int;
      
      function validate() : void;
   }
}
