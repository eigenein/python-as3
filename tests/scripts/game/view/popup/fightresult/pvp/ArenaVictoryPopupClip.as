package game.view.popup.fightresult.pvp
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import feathers.controls.LayoutGroup;
   import feathers.layout.VerticalLayout;
   import flash.geom.Rectangle;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GuiClipLayoutContainer;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   
   public class ArenaVictoryPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_stats_inst0:ClipButtonLabeled;
      
      public var okButton:ClipButtonLabeled;
      
      public var tf_label_header:ClipLabel;
      
      public var tf_caption:ClipLabel;
      
      public var tf_place_after:ClipLabel;
      
      public var tf_place_before:ClipLabel;
      
      public var tf_label_place:ClipLabel;
      
      public var tf_label_battles:ClipLabel;
      
      public var double_arrow_inst0:ClipSprite;
      
      public var animation_EpicRays_inst0:GuiAnimation;
      
      public var glowspot_inst0:ClipSprite;
      
      public var hero_list_layout_container:GuiClipLayoutContainer;
      
      public var GlowBigRed_218_218_2_inst0:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst0:GuiClipScale3Image;
      
      public var GlowRed_100_100_2_inst1:GuiClipScale3Image;
      
      public var ribbon_154_154_2_inst0:ClipSprite;
      
      public var layout_timer:ClipLayout;
      
      public var flatGlowRed:GuiClipScale3Image;
      
      public var tf_label_reward:ClipLabel;
      
      public var reward_layout:ClipLayout;
      
      public var glowspot_reward:ClipSprite;
      
      public var tf_label_battle_reward:ClipLabel;
      
      public var battle_reward_layout:ClipLayout;
      
      public var buttons_container:ClipLayout;
      
      public var battle_reward_container:ClipLayout;
      
      public var middle_container:ClipLayout;
      
      public var bottom_container:ClipLayout;
      
      public var top_container:ClipLayout;
      
      public var bounds_layout_container:LayoutGroup;
      
      public function ArenaVictoryPopupClip()
      {
         tf_label_header = new ClipLabel();
         tf_caption = new ClipLabel();
         tf_place_after = new ClipLabel(true);
         tf_place_before = new ClipLabel(true);
         tf_label_place = new ClipLabel(true);
         tf_label_battles = new ClipLabel(true);
         double_arrow_inst0 = new ClipSprite();
         animation_EpicRays_inst0 = new GuiAnimation();
         glowspot_inst0 = new ClipSprite();
         hero_list_layout_container = new GuiClipLayoutContainer();
         GlowRed_100_100_2_inst0 = new GuiClipScale3Image(100,2);
         GlowRed_100_100_2_inst1 = new GuiClipScale3Image(100,2);
         ribbon_154_154_2_inst0 = new ClipSprite();
         layout_timer = ClipLayout.horizontalMiddleCentered(10,tf_label_place,tf_place_before,double_arrow_inst0,tf_place_after,tf_label_battles);
         flatGlowRed = new GuiClipScale3Image(150,2);
         tf_label_reward = new ClipLabel(true);
         reward_layout = ClipLayout.horizontalMiddleCentered(10,tf_label_reward);
         glowspot_reward = new ClipSprite();
         tf_label_battle_reward = new ClipLabel(true);
         battle_reward_layout = ClipLayout.horizontalMiddleCentered(10,tf_label_battle_reward);
         buttons_container = new ClipLayout(null);
         battle_reward_container = new ClipLayout(null);
         middle_container = new ClipLayout(null);
         bottom_container = new ClipLayout(null);
         top_container = new ClipLayout(null);
         bounds_layout_container = new LayoutGroup();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         addChildToContainer(middle_container,reward_layout);
         addChildToContainer(middle_container,flatGlowRed.graphics);
         addChildToContainer(middle_container,glowspot_reward.graphics);
         addChildToContainer(bottom_container,GlowBigRed_218_218_2_inst0.graphics);
         addChildToContainer(bottom_container,hero_list_layout_container.graphics);
         addChildToContainer(bottom_container,glowspot_inst0.graphics);
         addChildToContainer(battle_reward_container,battle_reward_layout);
         addChildToContainer(buttons_container,button_stats_inst0.graphics);
         addChildToContainer(buttons_container,okButton.graphics);
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.verticalAlign = "top";
         _loc2_.horizontalAlign = "center";
         bounds_layout_container.layout = _loc2_;
         bounds_layout_container.addChild(top_container.graphics);
         bounds_layout_container.addChild(middle_container.graphics);
         bounds_layout_container.addChild(bottom_container.graphics);
         bounds_layout_container.addChild(battle_reward_container.graphics);
         bounds_layout_container.addChild(buttons_container.graphics);
         container.addChild(bounds_layout_container);
      }
      
      private function addChildToContainer(param1:DisplayObjectContainer, param2:DisplayObject) : void
      {
         var _loc3_:Rectangle = param2.getBounds(param1);
         param2.x = _loc3_.x;
         param2.y = _loc3_.y;
         param1.addChild(param2);
      }
   }
}
