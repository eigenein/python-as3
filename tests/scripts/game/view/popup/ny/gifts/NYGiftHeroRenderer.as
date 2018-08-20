package game.view.popup.ny.gifts
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.AssetStorageUtil;
   import game.data.storage.hero.HeroDescription;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.popup.hero.MiniHeroStarDisplay;
   
   public class NYGiftHeroRenderer extends ClipButton
   {
       
      
      public var item_border_image:GuiClipImage;
      
      public var item_image:GuiClipImage;
      
      public var star_container:ClipLayout;
      
      public var tf_title:ClipLabel;
      
      public var tf_desc:ClipLabel;
      
      public var layout_texts:ClipLayout;
      
      public var starDisplay:MiniHeroStarDisplay;
      
      public function NYGiftHeroRenderer()
      {
         item_border_image = new GuiClipImage();
         item_image = new GuiClipImage();
         star_container = ClipLayout.none();
         tf_title = new ClipLabel();
         tf_desc = new ClipLabel();
         layout_texts = ClipLayout.verticalMiddleLeft(5,tf_title,tf_desc);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_texts.touchable = false;
      }
      
      public function setData(param1:HeroDescription, param2:String) : void
      {
         item_border_image.image.texture = AssetStorage.rsx.popup_theme.getTexture("border_super_white");
         item_image.image.texture = AssetStorageUtil.getItemTexture(new InventoryItem(param1,1));
         starDisplay = new MiniHeroStarDisplay();
         starDisplay.touchable = false;
         starDisplay.width = star_container.width;
         star_container.addChild(starDisplay);
         starDisplay.setValue(param1.startingStar.star.id);
         starDisplay.visible = true;
         tf_title.text = param1.name;
         tf_desc.text = param2;
      }
   }
}
