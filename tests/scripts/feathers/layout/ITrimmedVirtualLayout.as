package feathers.layout
{
   public interface ITrimmedVirtualLayout extends IVirtualLayout
   {
       
      
      function get beforeVirtualizedItemCount() : int;
      
      function set beforeVirtualizedItemCount(param1:int) : void;
      
      function get afterVirtualizedItemCount() : int;
      
      function set afterVirtualizedItemCount(param1:int) : void;
   }
}
