package game.data.storage.clan
{
   import game.data.cost.CostData;
   import game.data.storage.DescriptionBase;
   import game.model.user.Player;
   
   public class ClanSummoningCircleDescription extends DescriptionBase
   {
       
      
      private var _cost_single:CostData;
      
      private var _cost_pack:CostData;
      
      private var _cost_pack_x10:CostData;
      
      private var _pack_amount:int;
      
      public function ClanSummoningCircleDescription(param1:Object)
      {
         super();
         _id = param1.id;
         _cost_single = new CostData(param1.cost_single);
         _cost_pack = new CostData(param1.cost_pack);
         _cost_pack_x10 = new CostData(param1.cost_pack_x10);
         _pack_amount = param1.pack_amount;
      }
      
      public function get cost_single() : CostData
      {
         return _cost_single;
      }
      
      public function get cost_pack() : CostData
      {
         return _cost_pack;
      }
      
      public function get cost_pack_x10() : CostData
      {
         return _cost_pack_x10;
      }
      
      public function get pack_amount() : int
      {
         return _pack_amount;
      }
      
      public function getCostSingle(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.summoningCircleOpenSingle(_cost_single,_id);
      }
      
      public function getCostPack(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.summoningCircleOpenPack(_cost_pack,1);
      }
      
      public function getCostPackX10(param1:Player) : CostData
      {
         return param1.specialOffer.costReplace.summoningCircleOpenPack10(_cost_pack_x10,10);
      }
   }
}
