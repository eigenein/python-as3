package game.view.popup.test
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.battle.gui.BattleGuiToggleButton;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipButtonLabeledUnderlined;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipList;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.test.grade.BattleTestGradeClip;
   
   public class BattleTestStatsClip extends GuiClipNestedContainer
   {
       
      
      public var inst0_mainframe_64_64_2_2:ClipSprite;
      
      public var button_close:ClipButton;
      
      public var button_start:BattleGuiToggleButton;
      
      public var button_clear:ClipButtonLabeled;
      
      public var button_fill_empty_slots:BattleGuiToggleButton;
      
      public var button_refresh:ClipButtonLabeled;
      
      public var button_different_grade:ClipButtonLabeled;
      
      public var button_different_grade_drop:ClipButtonLabeled;
      
      public var button_start_one:ClipButtonLabeled;
      
      public var button_toggleInterpreter:BattleGuiToggleButton;
      
      public var button_lock_right:BattleGuiToggleButton;
      
      public var button_config:ClipButtonLabeled;
      
      public var button_skin:ClipButtonLabeled;
      
      public var button_winrate_only:ClipButtonLabeledUnderlined;
      
      public var button_attackersDefenders:ClipButtonLabeledUnderlined;
      
      public const list_battleground_scrollbar:GameScrollBar = new GameScrollBar();
      
      public const list_battleground:ClipList = new ClipListWithScroll(BattleTestStatsBattlegroundListItem,list_battleground_scrollbar);
      
      public const list_battleground_item:ClipDataProvider = list_battleground.itemClipProvider;
      
      public var grade_left:BattleTestGradeClip;
      
      public var grade_right:BattleTestGradeClip;
      
      public var team_block_left:ClipTeamBlock;
      
      public var team_block_right:ClipTeamBlock;
      
      public var tf_power_left:ClipLabel;
      
      public var tf_power_right:ClipLabel;
      
      public var counters:ClipCounters;
      
      public var label_stat_output:ClipInput;
      
      public var tf_config_label:ClipLabel;
      
      public var tf_stats_label:ClipLabel;
      
      public var tf_refresh_result:ClipLabel;
      
      public var tf_copy_result:ClipLabel;
      
      public var tf_grade_different:ClipLabel;
      
      public var tf_lock_label:ClipLabel;
      
      public var tf_winrate:ClipLabel;
      
      public const tf_copy_url:ClipLabel = new ClipLabel();
      
      public var background:ClipSprite;
      
      public const layout_tabs:ClipLayout = ClipLayout.vertical(-16);
      
      public const item_heroTab:ClipDataProvider = new ClipDataProvider();
      
      public const button_stat_task:ClipButtonLabeledUnderlined = new ClipButtonLabeledUnderlined();
      
      public function BattleTestStatsClip()
      {
         super();
      }
   }
}
