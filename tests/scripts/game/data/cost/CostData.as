package game.data.cost
{
   import game.data.ResourceListData;
   
   public class CostData extends ResourceListData
   {
       
      
      public function CostData(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function _createSplitEntity() : ResourceListData
      {
         return new CostData();
      }
   }
}
