package game.mechanics.titan_arena.popup.reward
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.tooltip.TooltipTextView;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TitanArenaRewardItemRenderer extends GuiClipNestedContainer
   {
       
      
      public var tf_amount:ClipLabel;
      
      public var icon:GuiClipImage;
      
      public var icon_bg:ClipSprite;
      
      public var icon_coin:GuiClipImage;
      
      public var bg:GuiClipScale3Image;
      
      private var tooltipVO:TooltipVO;
      
      public function TitanArenaRewardItemRenderer()
      {
         tf_amount = new ClipLabel(true);
         icon = new GuiClipImage();
         icon_bg = new ClipSprite();
         icon_coin = new GuiClipImage();
         bg = new GuiClipScale3Image(12,1);
         tooltipVO = new TooltipVO(TooltipTextView,"test");
         super();
      }
      
      public function dispose() : void
      {
         TooltipHelper.removeTooltip(graphics);
      }
      
      public function set data(param1:InventoryItem) : void
      {
         var _loc2_:* = null;
         graphics.visible = param1;
         if(param1)
         {
            _loc2_ = param1 as InventoryItem;
            tf_amount.text = _loc2_.amount.toString();
            tf_amount.validate();
            bg.graphics.width = tf_amount.width + 30;
            if(_loc2_.item.iconAssetTexture)
            {
               var _loc3_:Boolean = false;
               icon.graphics.visible = _loc3_;
               icon_bg.graphics.visible = _loc3_;
               icon_coin.graphics.visible = true;
               icon_coin.image.texture = AssetStorage.inventory.getItemGUIIconTexture(_loc2_.item);
            }
            else
            {
               icon.image.texture = AssetStorage.inventory.getItemTexture(_loc2_.item);
               _loc3_ = true;
               icon.graphics.visible = _loc3_;
               icon_bg.graphics.visible = _loc3_;
               icon_coin.graphics.visible = false;
            }
            tooltipVO.hintData = param1.name + "\n" + ColorUtils.hexToRGBFormat(16573879) + param1.descText;
         }
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         TooltipHelper.addTooltip(graphics,tooltipVO);
      }
   }
}
