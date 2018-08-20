package game.view.popup.chest
{
   import com.progrestar.common.lang.Translate;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.assets.storage.AssetStorage;
   import game.data.storage.chest.ChestRewardPresentationValueObject;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.reward.multi.InventoryItemRenderer;
   
   public class ChestDropPresentationRendererSpecial extends GuiClipNestedContainer
   {
       
      
      public var item_icon:InventoryItemRenderer;
      
      public var star_1:ClipSprite;
      
      public var star_2:ClipSprite;
      
      public var star_3:ClipSprite;
      
      public var star_4:ClipSprite;
      
      public var star_5:ClipSprite;
      
      public var star_epic:GuiAnimation;
      
      public var star_container:ClipLayout;
      
      public var tf_special_reward:ClipLabel;
      
      public function ChestDropPresentationRendererSpecial()
      {
         star_1 = new ClipSprite();
         star_2 = new ClipSprite();
         star_3 = new ClipSprite();
         star_4 = new ClipSprite();
         star_5 = new ClipSprite();
         star_epic = new GuiAnimation();
         star_container = ClipLayout.horizontalMiddleCentered(-5,star_1,star_2,star_3,star_4,star_5);
         tf_special_reward = new ClipLabel();
         super();
      }
      
      public function setData(param1:ChestRewardPresentationValueObject) : void
      {
         var _loc7_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc2_:GuiAnimation = AssetStorage.rsx.chest_graphics.create(GuiAnimation,"heroitem_hihlite_back");
         container.addChildAt(_loc2_.graphics,0);
         var _loc4_:GuiAnimation = AssetStorage.rsx.chest_graphics.create(GuiAnimation,"heroitem_hihlite_front");
         container.addChild(_loc4_.graphics);
         _loc4_.graphics.touchable = false;
         item_icon.setData(new InventoryItem(param1.item,1));
         item_icon.item_counter.graphics.visible = false;
         if(param1.item is HeroDescription)
         {
            _loc7_ = param1.item as HeroDescription;
            _loc3_ = 5;
            _loc6_ = 1;
            while(_loc6_ <= _loc3_)
            {
               _loc5_ = this["star_" + _loc6_];
               _loc5_.graphics.visible = _loc6_ <= _loc7_.startingStar.star.id && _loc7_.startingStar.star.id < 6;
               _loc6_++;
            }
            star_epic.graphics.visible = _loc7_.startingStar.star.id == 6;
         }
         tf_special_reward.text = Translate.translate("UI_CHES_DROP_BLOCK_TF_SPECIAL_REWARD");
      }
   }
}
