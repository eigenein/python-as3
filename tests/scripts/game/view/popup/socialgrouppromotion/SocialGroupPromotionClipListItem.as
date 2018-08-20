package game.view.popup.socialgrouppromotion
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipScale9Image;
   import game.assets.storage.AssetStorage;
   import game.mediator.gui.popup.socialgrouppromotion.SocialGroupPromotionMediator;
   import game.mediator.gui.tooltip.TooltipHelper;
   import game.mediator.gui.tooltip.TooltipVO;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.IClipListItem;
   import game.view.gui.components.tooltip.TooltipTextView;
   import idv.cjcat.signals.Signal;
   
   public class SocialGroupPromotionClipListItem extends ClipButton implements IClipListItem
   {
       
      
      private var mediator:SocialGroupPromotionMediator;
      
      private var tooltipVO:TooltipVO;
      
      public var tf_text:ClipLabel;
      
      public var layout_text:ClipLayout;
      
      public var image_icon:GuiClipImage;
      
      public var bg:GuiClipScale9Image;
      
      public function SocialGroupPromotionClipListItem()
      {
         tf_text = new ClipLabel(true);
         layout_text = ClipLayout.none(tf_text);
         super();
      }
      
      public function dispose() : void
      {
         if(tooltipVO)
         {
            tooltipVO = null;
            TooltipHelper.removeTooltip(graphics);
         }
         if(mediator)
         {
            signal_click.remove(handler_click);
         }
      }
      
      public function get signal_select() : Signal
      {
         return null;
      }
      
      public function setSelected(param1:Boolean) : void
      {
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         signal_click.add(handler_click);
      }
      
      public function setData(param1:*) : void
      {
         var _loc2_:SocialGroupPromotionMediator = param1 as SocialGroupPromotionMediator;
         if(_loc2_)
         {
            this.mediator = _loc2_;
            image_icon.image.texture = AssetStorage.rsx.popup_theme.getTexture(_loc2_.iconTexture);
            tf_text.text = _loc2_.messageText;
            if(tooltipVO)
            {
               tooltipVO = null;
               TooltipHelper.removeTooltip(graphics);
            }
            if(_loc2_.hoverText)
            {
               tooltipVO = new TooltipVO(TooltipTextView,_loc2_.hoverText);
               TooltipHelper.addTooltip(graphics,tooltipVO);
            }
            resize();
         }
      }
      
      public function resize() : void
      {
         if(bg)
         {
            tf_text.validate();
            layout_text.width = tf_text.width;
            bg.graphics.width = Math.ceil(layout_text.x + layout_text.width + image_icon.graphics.x * 2);
         }
      }
      
      private function handler_click() : void
      {
         if(mediator)
         {
            mediator.action_select();
         }
      }
   }
}
