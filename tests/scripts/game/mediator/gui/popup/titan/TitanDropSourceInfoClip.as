package game.mediator.gui.popup.titan
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class TitanDropSourceInfoClip extends GuiClipNestedContainer
   {
       
      
      public var button_fragment_find_1:ClipButtonLabeled;
      
      public var button_fragment_find_2:ClipButtonLabeled;
      
      public var tf_label_fragments_find_1:ClipLabel;
      
      public var tf_label_fragments_find_2:ClipLabel;
      
      public var dungeon_icon_inst0:ClipSprite;
      
      public var summoning_circle_icon_inst0:ClipSprite;
      
      public var bg1:GuiClipScale9Image;
      
      public var bg2:GuiClipScale9Image;
      
      public var layout_group_1:ClipLayout;
      
      public var layout_group_2:ClipLayout;
      
      public function TitanDropSourceInfoClip()
      {
         button_fragment_find_1 = new ClipButtonLabeled();
         button_fragment_find_2 = new ClipButtonLabeled();
         tf_label_fragments_find_1 = new ClipLabel();
         tf_label_fragments_find_2 = new ClipLabel();
         dungeon_icon_inst0 = new ClipSprite();
         summoning_circle_icon_inst0 = new ClipSprite();
         bg1 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         bg2 = new GuiClipScale9Image(new Rectangle(12,12,12,12));
         layout_group_1 = ClipLayout.horizontal(4,tf_label_fragments_find_1);
         layout_group_2 = ClipLayout.horizontal(4,tf_label_fragments_find_2);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_label_fragments_find_1.text = Translate.translate("UI_POPUP_TITAN_GUILD_DUNGEON");
         tf_label_fragments_find_2.text = Translate.translate("UI_DIALOG_TITAN_SUMMON_CIRCLE");
         button_fragment_find_1.label = Translate.translate("UI_DIALOG_TITAN_FIND");
         button_fragment_find_2.label = Translate.translate("UI_DIALOG_TITAN_FIND");
      }
   }
}
