package game.mediator.gui.popup.chat.responses
{
   import engine.core.clipgui.ClipSpriteUntouchable;
   import feathers.layout.VerticalLayout;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipList;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.gui.components.MiniHeroTeamRenderer;
   import game.view.popup.arena.PlayerPortraitClip;
   
   public class ChatChallengeResponsesPopupClip extends PopupClipBase
   {
       
      
      public const portrait:PlayerPortraitClip = new PlayerPortraitClip();
      
      public const tf_nickname:ClipLabel = new ClipLabel();
      
      public const tf_date:ClipLabel = new ClipLabel();
      
      public const team:MiniHeroTeamRenderer = new MiniHeroTeamRenderer();
      
      public const layout_top_left:ClipLayout = ClipLayout.none(portrait,tf_nickname,tf_date);
      
      public const layout_top_right:ClipLayout = ClipLayout.none(team);
      
      public const layout_top:ClipLayout = ClipLayout.horizontalCentered(0,layout_top_left,layout_top_right);
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const list:ClipList = new ClipList(ClipListItemChatChallengeResponses);
      
      public const list_item:ClipDataProvider = list.itemClipProvider;
      
      public const scrollbar:GameScrollBar = new GameScrollBar();
      
      public function ChatChallengeResponsesPopupClip()
      {
         super();
         list.list = new GameScrolledList(scrollbar,gradient_top.graphics,gradient_bottom.graphics);
         var _loc1_:VerticalLayout = new VerticalLayout();
         _loc1_.paddingTop = 5;
         _loc1_.paddingBottom = 20;
         _loc1_.gap = 5;
         list.list.layout = _loc1_;
      }
   }
}
