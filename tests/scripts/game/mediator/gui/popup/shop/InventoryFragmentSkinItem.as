package game.mediator.gui.popup.shop
{
   import com.progrestar.common.lang.Translate;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.skin.SkinDescription;
   import game.model.GameModel;
   import game.model.user.Player;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.inventory.InventoryFragmentItem;
   
   public class InventoryFragmentSkinItem extends InventoryFragmentItem
   {
       
      
      public function InventoryFragmentSkinItem(param1:InventoryItemDescription, param2:Number = 1)
      {
         super(param1,param2);
      }
      
      override public function get descText() : String
      {
         var _loc3_:Player = GameModel.instance.player;
         var _loc1_:SkinDescription = item as SkinDescription;
         var _loc2_:PlayerHeroEntry = _loc3_.heroes.getById(_loc1_.heroId);
         if(_loc2_ && _loc2_.skinData.getSkinLevelByID(_loc1_.id) > 0)
         {
            return Translate.translate("UI_TRIPLE_SKI_BUNDLE_RENDERER_TF_SKIN_OWNED");
         }
         if(_loc2_)
         {
            return Translate.translateArgs("UI_DIALOG_NEW_SKIN_TITLE");
         }
         if(_loc3_.inventory.getFragmentCount(_loc1_) > 0)
         {
            return Translate.translate("UI_TRIPLE_SKI_BUNDLE_RENDERER_TF_SKIN_OWNED");
         }
         return Translate.translateArgs("UI_TRIPLE_SKI_BUNDLE_RENDERER_MSG_NO_HERO_HEADER") + "\n\n" + Translate.translateArgs("UI_TRIPLE_SKI_BUNDLE_RENDERER_MSG_NO_HERO_TEXT");
      }
   }
}
