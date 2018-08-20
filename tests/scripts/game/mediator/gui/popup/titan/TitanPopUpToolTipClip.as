package game.mediator.gui.popup.titan
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.SpecialClipLabel;
   import game.view.popup.quest.QuestRewardItemRenderer;
   
   public class TitanPopUpToolTipClip extends GuiClipNestedContainer
   {
       
      
      public var power_icon:ClipSprite;
      
      public var tf_power:SpecialClipLabel;
      
      public var layout_power:ClipLayout;
      
      public var tf_pyramid:ClipLabel;
      
      public var pyramid_counter:QuestRewardItemRenderer;
      
      public var layout_spark:ClipLayout;
      
      public function TitanPopUpToolTipClip()
      {
         power_icon = new ClipSprite();
         tf_power = new SpecialClipLabel(true);
         layout_power = ClipLayout.horizontalMiddleCentered(0,power_icon,tf_power);
         tf_pyramid = new ClipLabel();
         pyramid_counter = new QuestRewardItemRenderer();
         layout_spark = ClipLayout.horizontalMiddleCentered(0,pyramid_counter);
         super();
      }
   }
}
