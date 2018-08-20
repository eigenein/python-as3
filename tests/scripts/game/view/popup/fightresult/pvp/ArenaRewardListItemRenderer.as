package game.view.popup.fightresult.pvp
{
   import game.assets.storage.AssetStorage;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class ArenaRewardListItemRenderer extends ListItemRenderer
   {
       
      
      private var clip:QuestRewardItemRenderer;
      
      public function ArenaRewardListItemRenderer()
      {
         super();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:InventoryItem = data as InventoryItem;
         if(_loc1_ != null)
         {
            clip.data = _loc1_;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(QuestRewardItemRenderer,"quest_reward_item");
         addChild(clip.graphics);
      }
   }
}
