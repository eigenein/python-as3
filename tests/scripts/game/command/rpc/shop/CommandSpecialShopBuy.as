package game.command.rpc.shop
{
   import game.command.rpc.CostCommand;
   import game.command.rpc.RpcRequest;
   import game.data.reward.RewardData;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.shop.SpecialShopHeroValueObject;
   import game.model.user.shop.SpecialShopMerchant;
   import game.model.user.shop.SpecialShopSlotValueObject;
   
   public class CommandSpecialShopBuy extends CostCommand
   {
       
      
      private var _merchant:SpecialShopMerchant;
      
      private var _hero:SpecialShopHeroValueObject;
      
      public function CommandSpecialShopBuy(param1:SpecialShopMerchant, param2:SpecialShopHeroValueObject)
      {
         super();
         _merchant = param1;
         _hero = param2;
         rpcRequest = new RpcRequest("heroesMerchantBuy");
         rpcRequest.writeParam("heroId",param2.heroId);
         _cost = param2.getTotalCost();
      }
      
      override public function clientExecute(param1:Player) : void
      {
         _reward = new RewardData(this.result.body);
         _merchant.dismiss();
         var _loc2_:PlayerHeroEntry = param1.heroes.getById(_hero.heroId);
         if(_loc2_.color.next)
         {
            param1.heroes.heroPromoteColor(_loc2_);
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = _hero.slots;
            for each(var _loc3_ in _hero.slots)
            {
               if(_loc3_.canBuy())
               {
                  param1.heroes.heroInsertItem(_loc2_,_loc3_.heroSlotId);
               }
            }
         }
         super.clientExecute(param1);
      }
   }
}
