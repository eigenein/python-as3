package game.data.storage.chest
{
   import com.progrestar.common.lang.Translate;
   import game.data.cost.CostData;
   import game.data.reward.RewardData;
   import game.data.storage.DescriptionBase;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.tutorial.tutorialtarget.ITutorialTargetKey;
   
   public class ChestDescription extends DescriptionBase implements ITutorialTargetKey
   {
       
      
      public var ident:String;
      
      public var cost:CostData;
      
      public var packCost:CostData;
      
      public var packAmount:int;
      
      public var freeRefill:int;
      
      public var constName:String;
      
      private var _rewardPresentation:ChestRewardPresentation;
      
      private var _publicRewardList:Vector.<InventoryItem>;
      
      public function ChestDescription(param1:Object)
      {
         super();
         constName = param1.constName;
         ident = param1.ident;
         cost = new CostData(param1.cost);
         packCost = new CostData(param1.packCost);
         packAmount = param1.packAmount;
         freeRefill = param1.freeRefill;
         var _loc2_:RewardData = new RewardData(param1.publicRewards);
         _publicRewardList = _loc2_.outputDisplay;
         _rewardPresentation = new ChestRewardPresentation(param1.rewardPresentationExtended);
      }
      
      public function get rewardPresentation() : ChestRewardPresentation
      {
         return _rewardPresentation;
      }
      
      public function get publicRewardList() : Vector.<InventoryItem>
      {
         return _publicRewardList;
      }
      
      override public function applyLocale() : void
      {
         _name = Translate.translate("LIB_CHEST_NAME_" + ident);
      }
   }
}
