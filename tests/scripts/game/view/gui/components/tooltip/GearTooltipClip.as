package game.view.gui.components.tooltip
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.gui.components.hero.MiniHeroPortraitClip;
   
   public class GearTooltipClip extends GuiClipNestedContainer
   {
       
      
      public var tf_item_name:ClipLabel;
      
      public var tf_item_desc:ClipLabel;
      
      public var tf_hero_level:SpecialClipLabel;
      
      public var tf_hero_list_label:ClipLabel;
      
      public var hero_1:MiniHeroPortraitClip;
      
      public var hero_2:MiniHeroPortraitClip;
      
      public var hero_3:MiniHeroPortraitClip;
      
      public var hero_4:MiniHeroPortraitClip;
      
      public var hero_plus_count:GearTooltipClipPlus;
      
      public var bg:GuiClipScale9Image;
      
      public var hero_list_container:ClipLayout;
      
      public var tooltip_layout:ClipLayout;
      
      public var hero:Vector.<MiniHeroPortraitClip>;
      
      public function GearTooltipClip()
      {
         tf_item_name = new ClipLabel();
         tf_item_desc = new ClipLabel();
         tf_hero_level = new SpecialClipLabel();
         tf_hero_list_label = new ClipLabel();
         hero_1 = new MiniHeroPortraitClip();
         hero_2 = new MiniHeroPortraitClip();
         hero_3 = new MiniHeroPortraitClip();
         hero_4 = new MiniHeroPortraitClip();
         hero_plus_count = new GearTooltipClipPlus();
         bg = new GuiClipScale9Image(new Rectangle(16,16,16,16));
         hero_list_container = ClipLayout.horizontalMiddleCentered(0,hero_1,hero_2,hero_3,hero_4,hero_plus_count);
         tooltip_layout = ClipLayout.verticalCenter(4,tf_item_name,tf_item_desc,tf_hero_level,tf_hero_list_label,hero_list_container);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         hero = new <MiniHeroPortraitClip>[hero_1,hero_2,hero_3,hero_4];
         tooltip_layout.height = NaN;
      }
   }
}
