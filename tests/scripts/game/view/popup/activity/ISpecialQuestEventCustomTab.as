package game.view.popup.activity
{
   import starling.display.DisplayObject;
   
   public interface ISpecialQuestEventCustomTab
   {
       
      
      function get graphics() : DisplayObject;
      
      function get name() : String;
      
      function get sortOrder() : int;
      
      function dispose() : void;
   }
}
