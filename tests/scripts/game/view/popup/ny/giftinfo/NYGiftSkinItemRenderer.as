package game.view.popup.ny.giftinfo
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import game.assets.storage.AssetStorage;
   import game.data.storage.DataStorage;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.skin.SkinDescription;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.DataClipButton;
   import game.view.gui.components.tooltip.TooltipTextView;
   
   public class NYGiftSkinItemRenderer extends DataClipButton
   {
       
      
      private var skin:SkinDescription;
      
      private var tooltip:TooltipVO;
      
      public var border:ClipSprite;
      
      public var image_item:GuiClipImage;
      
      public function NYGiftSkinItemRenderer()
      {
         tooltip = new TooltipVO(TooltipTextView,"");
         border = new ClipSprite();
         image_item = new GuiClipImage();
         super(SkinDescription);
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(this.graphics);
      }
      
      public function setData(param1:SkinDescription) : void
      {
         if(skin == param1)
         {
            return;
         }
         skin = param1;
         image_item.image.texture = AssetStorage.inventory.getSkinTexture(null,skin);
         var _loc2_:HeroDescription = DataStorage.hero.getHeroById(skin.heroId);
         if(_loc2_)
         {
            tooltip.hintData = _loc2_.name + " - " + skin.name;
         }
         else
         {
            tooltip.hintData = skin.name;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         TooltipHelper.addTooltip(this.graphics,tooltip);
      }
      
      override protected function getClickData() : *
      {
         return skin;
      }
   }
}
