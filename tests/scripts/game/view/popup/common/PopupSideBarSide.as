package game.view.popup.common
{
   public class PopupSideBarSide
   {
      
      public static const left:PopupSideBarSide = new PopupSideBarSide("LEFT");
      
      public static const right:PopupSideBarSide = new PopupSideBarSide("RIGHT");
      
      public static const top:PopupSideBarSide = new PopupSideBarSide("TOP");
      
      public static const bottom:PopupSideBarSide = new PopupSideBarSide("BOTTOM");
       
      
      private var name:String;
      
      public function PopupSideBarSide(param1:String)
      {
         super();
         this.name = param1;
      }
   }
}
