package ru.crazybit.socexp.view.core.text.renderer
{
   import starling.display.QuadBatch;
   
   public class QuadBatchList extends QuadBatch
   {
       
      
      public var prevUsed:QuadBatchList;
      
      public var nextFree:QuadBatchList;
      
      public function QuadBatchList()
      {
         super();
      }
   }
}
