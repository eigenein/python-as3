package game.view.popup.fightresult.pve
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   
   public class MissionDefeatPopupClip extends GuiClipNestedContainer
   {
       
      
      public var bounds_layout_container:GuiClipLayoutContainer;
      
      public var glowspot_inst0:ClipSprite;
      
      public var glowspot_inst1:ClipSprite;
      
      public var glowspot_inst2:ClipSprite;
      
      public var winBG_18_18_4_4_inst0:GuiClipScale9Image;
      
      public var glowspot_inst3:ClipSprite;
      
      public var winBG_18_18_4_4_inst1:GuiClipScale9Image;
      
      public var tf_label_header:ClipLabel;
      
      public var okButton:ClipButtonLabeled;
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var GlowRed_100_100_2_inst1:GuiClipScale3Image;
      
      public var ribbon_154_154_2_inst0:GuiClipScale3Image;
      
      public var SkullBack_inst0:ClipSprite;
      
      public var layout_main:ClipLayout;
      
      public function MissionDefeatPopupClip()
      {
         layout_main = ClipLayout.horizontalMiddleCentered(0);
         super();
         winBG_18_18_4_4_inst0 = new GuiClipScale9Image(new Rectangle(18,18,4,4));
         glowspot_inst2 = new ClipSprite();
         winBG_18_18_4_4_inst0 = new GuiClipScale9Image(new Rectangle(18,18,4,4));
         GlowRed_100_100_2_inst1 = new GuiClipScale3Image(100,2);
         ribbon_154_154_2_inst0 = new GuiClipScale3Image();
         SkullBack_inst0 = new ClipSprite();
         glowspot_inst0 = new ClipSprite();
         glowspot_inst1 = new ClipSprite();
         glowspot_inst2 = new ClipSprite();
         winBG_18_18_4_4_inst0 = new GuiClipScale9Image(new Rectangle(18,18,4,4));
         glowspot_inst3 = new ClipSprite();
         winBG_18_18_4_4_inst1 = new GuiClipScale9Image(new Rectangle(18,18,4,4));
      }
      
      public function dispose() : void
      {
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
