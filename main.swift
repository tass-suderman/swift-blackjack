/**********
*  Tass Suderman
*  Krishiv Soni
***/

/**
* Constant Variables  --  Line 19
* Enumerations  --  Line 77
* Structs  --  Line 141
* Classes  --  Line 296
* Global Variables  --  Line 660
* ASCII Rendering Methods  --  Line 671
* Controller Methods -- Line 837
* Gameplay Loop Method  --  Line 1053
* Invoked Methods  --  Line 1114
**/

/***********************************************************************
* Constant Variables
*/

let DEALER_NAME = "Daniel" //Dealer's name; can be changed to whatever is funniest at the moment.
//Keep it under (TABLE_WIDTH - 49) though, or you'll run into trouble

let TABLE_WIDTH  = 58; //Width of the rendered table -- 58 was chosen because that size matches the console width of Replit users that are not logged in

let STARTING_BALANCE = 100

let TABLE_STYLE = ["║","═","╔","╗","╚","╝", "—" ,"╟", "╢"]
let SIDE_BAR = TABLE_STYLE[0]
let HORIZONTAL_BAR =  TABLE_STYLE[1]
let TOP_LEFT_BAR =  TABLE_STYLE[2]
let TOP_RIGHT_BAR =  TABLE_STYLE[3]
let BOTTOM_LEFT_BAR =  TABLE_STYLE[4]
let BOTTOM_RIGHT_BAR =  TABLE_STYLE[5]
let TABLE_DIVIDER = TABLE_STYLE[6]
let TABLE_DIVIDER_LEFT = TABLE_STYLE[7]
let TABLE_DIVIDER_RIGHT = TABLE_STYLE[8]

let CARD_BACK = "⟡"
let WAGER_MENU = ["Increase Wager [W] | Decrease Wager [S]","Enter Dollar Amount [i] | Confirm Amount [Enter]","Quit Game [X]"]
let WAGER_INPUT = ["How much would you like to wager?","Leave blank or enter 0 to cancel"]
let ABANDON_GAME_MESSAGE = ["Are you sure you would like to forfeit?","Forfeit Game (Y/n):"]
let NEW_GAME_MESSAGE = ["New Game? (Y/n):"]
let TOP_BAR = TOP_LEFT_BAR + String(repeating: HORIZONTAL_BAR, count: TABLE_WIDTH) + TOP_RIGHT_BAR;
let BOTTOM_BAR = BOTTOM_LEFT_BAR + String(repeating: HORIZONTAL_BAR, count: TABLE_WIDTH) + BOTTOM_RIGHT_BAR;
let RULES = [ 
              "Rules of BlackJack:",
              "There is a deck of 52 cards;",
              "Jack/Queen/King are worth 10",
              "Numbered cards are worth their number",
              "Ace worth 1 or 11.",
              "Player bet and the dealer deals 2 cards each",
              "Players hit/stand; if they get over 21 they bust & lose.",
              "After all players are done,", 
              "the dealer reveals their facedown card",
              "and hits until they reach 17 and up.",
              "If dealer busts the player wins.",
              "Otherwise, the closest to 21 wins.",
              "If the first two cards are worth 21, it a a BlackJack",
              "This is an automatic win, unless dealer has a BlackJack."
]


let FULL_CONTROLLER = [ "[H] Hit | [S] Stand | [Q] View the Rules | [N] New Game" ]
let SMALL_CONTROLLER = [ "[Q] View the Rules | [N] New Game" ]

let greeting = ["Hello I am \(DEALER_NAME), your dealer.",
                "Let's play a game of Blackjack.",
                "How much would you like to wager?"]





/**********************************************************************
*Enumerations
*/


//RANK

/**
Instantiate as varable
Print variable -> print case name
Print numberValue -> print value of card (Ace is 11)
Print lowValue -> print value of card (Ace is 1)
print rawValue -> String value as seen on card
**/

/** Rank Enumeration
* - Rank Number
**/
public enum Rank : String
{
  case rA = "A",   r2 = "2",  r3 = "3",  r4 = "4",  r5 = "5",  r6 = "6",  r7 = "7",  r8 = "8",  r9 = "9",  r10 = "⒑",   rJ = "J",   rQ = "Q",  rK = "K"

  public var numberValue : Int
  {
    var avalue = 0 
    switch (self)
    {
      case .rA: avalue = 11
      case .r2: avalue = 2
      case .r3: avalue = 3
      case .r4: avalue = 4
      case .r5: avalue = 5
      case .r6: avalue = 6
      case .r7: avalue = 7
      case .r8: avalue = 8
      case .r9: avalue = 9
      case .r10: avalue = 10
      case .rJ: avalue = 10
      case .rQ: avalue = 10
      case .rK: avalue = 10
    }
    return avalue
  }


  public static let orderedRanks : [Rank] = [ rA, r2, r3, r4, r5, r6, r7, r8, r9, r10, rJ, rQ, rK ]

}


/**
*  Suit Enumeration
*  Stored as String value
**/
public enum Suit : String
{
  case Clubs = "♣", Diamonds = "♦", Hearts = "♥", Spades = "♠"

  public static let orderedSuits : [Suit] = [Clubs, Diamonds, Hearts, Spades]

}



/**************************************************************************
* Structs
*/


/**
*
* Card Struct
* Properties:
*   - rank : Rank Enum
*   - suit : Suit Enum
*   + isVisible : Bool -- false by default
*   + displayCard : Computed String Array -- Shows front or back, depending on visibility
*   - faceUp : String Array -- Shows front of card
*   - faceDown : String Array -- shows back of card
*   + description : Computed String returns a description of the card's suit and rank
*  Methods:
*   + getValue : Int -- returns the value of card, or 0 if not visible.
*   + getRank : Rank -- Returns the rank of Card
*   + showCard : Void -- Makes card visible -- sets isVisible to true
*/
public struct Card : CustomStringConvertible
{
  private var rank : Rank
  private var suit : Suit
  public var isVisible : Bool = false

  public static let CARD_FULL_WIDTH = 7 
  private static let CARD_WIDTH = 4
  private static let CARD_TOP = TOP_LEFT_BAR + String(repeating: HORIZONTAL_BAR, count: Card.CARD_WIDTH) + TOP_RIGHT_BAR;
  private static let CARD_BOTTOM = BOTTOM_LEFT_BAR + String(repeating: HORIZONTAL_BAR, count: Card.CARD_WIDTH) + BOTTOM_RIGHT_BAR;
  private static let CARD_BACK_MID = SIDE_BAR + String(repeating: CARD_BACK, count: CARD_WIDTH) + SIDE_BAR
  
  public var displayCard : [String] 
  {
    return isVisible ? faceUp : faceDown
  }

  private var faceUp : [String]
  {
    return [Card.CARD_TOP,
           "\(SIDE_BAR)   \(suit.rawValue)\(SIDE_BAR)",
           "\(SIDE_BAR) \(rank.rawValue)  \(SIDE_BAR)",
           "\(SIDE_BAR)\(suit.rawValue)   \(SIDE_BAR)",
           Card.CARD_BOTTOM]
    
    

  }
  
  private var faceDown : [String]
  {
  
     return [Card.CARD_TOP,
           Card.CARD_BACK_MID,
           Card.CARD_BACK_MID,
           Card.CARD_BACK_MID,
           Card.CARD_BOTTOM]
  }
  
  public func getValue() -> Int
  {
    return isVisible ?  self.rank.numberValue : 0
  }

  public func getRank() -> Rank
  {
    return self.rank;
  }
  public mutating func showCard() -> ()
  {
    self.isVisible = true
  }

  public var description : String { return "\(rank.rawValue) of \(suit.rawValue)" }
  
  
  public init(rank : Rank, suit: Suit)
  {
    self.rank = rank
    self.suit = suit
  }
}


/**
*
* HandValue Struct
* Properties:
*  + value : Int -- Total Value of hand
*  + hasHiddenCard : Bool -- Specifies whether all of the hand's value is known
*  + isPlayerHand : Bool -- Specifies whether this hand belongs to the player
*  + description : Computed String -- Returns a description of the value in the hand
*  + descLength : Computed Int -- returns the length of the description
**/
public struct HandValue : CustomStringConvertible
{
  public var value : Int
  public var hasHiddenCard : Bool
  public var isPlayerHand : Bool
  private static let YOUR_HAND = "Your Hand "
  private static let DEALER_HAND = "\(DEALER_NAME)'s Hand "
  
  public var description : String {
    let ownerName = self.isPlayerHand ? HandValue.YOUR_HAND : HandValue.DEALER_HAND
    if(hasHiddenCard)
    {
      return ownerName + "(\(value) + ?)"
    }
    else
    {
      return ownerName + "(\(value))"
    }
  }

  public var descLength : Int {
    return self.description.count;
  }

  public init(cards : [Card], isPlayerHand : Bool)
  {
    var val : Int = 0
    var numOfAces : Int = 0
    var hidden : Bool = false
    for card in cards
    {
      val = val + card.getValue()
      if card.isVisible 
      {
        if card.getRank() == Rank.rA
        {
          numOfAces = numOfAces + 1;
        }
      }
      else
      {
        hidden = true
      }
    }
    
    while val > 21 && numOfAces > 0
    {
      val = val - 10
      numOfAces = numOfAces - 1 
    }
    self.value = val
    self.hasHiddenCard = hidden
    self.isPlayerHand = isPlayerHand
    
  }
}




/***********************************************************************
* Game Class
*/
public class GameState
{
  private var deckOfCards : [Card] = []

  public var playerCards : [Card] = []

  public var dealerCards : [Card] = []

  public var balance = STARTING_BALANCE
  public var wager = 10

  public var cardHistory : [String] = []

  public var dealerValueDesc : HandValue {return HandValue(cards: dealerCards, isPlayerHand: false) }
  
  public var playerValueDesc : HandValue {return HandValue(cards: playerCards, isPlayerHand : true) }

  public var exitConsole : Bool = false
  
  /**
  *  gameTurn
  *    returns : Void -- handles a single turn of a blackjack game
  *    parameters:
  *      isPlayersTurn : Bool -- Whether or not the current turn is the player's turn
  *      advanceGame : Bool -- Whether or not to advance the game by a turn in this method invocation
  *      clear : Bool -- whether to clear the screen in this method invocation
  *      exitOnly : Bool -- whether to use the limited controller access mode
  **/
  private func gameTurn(isPlayersTurn: Bool, advanceGame: Bool, clear : Bool = true, exitOnly : Bool = false)
  {
    if exitConsole { return }
    if clear {  clearScreen() }
  
    if !exitOnly
    {
    printWithBorders(thingsToPrint: cardHistory)
    print(renderTable(dealerValue : dealerValueDesc, playerValue : playerValueDesc));
    }
    if playerCards.count == 2 && playerValueDesc.value == 21
      {
        dealerCards[1].showCard()
        clearScreen()
        print(renderTable(dealerValue: dealerValueDesc, playerValue: playerValueDesc))
        if dealerValueDesc.value == 21
        {
          tieGame()
        }
        else
        {
          winGame(withBlackJack: true)
        }
        return
      }
      if  playerValueDesc.value>21
      {
        loseGame()
        return
      }
      if(isPlayersTurn)
      {
        inputController(controllerCase: 5, exitOnly : exitOnly)
        return
      }
      
    if !advanceGame {return}
      if dealerValueDesc.value >= 17
      {
        
        
        if dealerValueDesc.value > 21
        {
          winGame()
          return
        }
        switch (dealerValueDesc.value - playerValueDesc.value)
        {
          case 1...Int.max: 
            loseGame()
            return
          case 0:
            tieGame()
            return
          case Int.min...0:
            winGame()
            return
          default: break
        }
  
        return
      }
    
    handleStand()
    
    
  }
    
    
    /**
    *  dealCards
    *  parameters:
    *    toPlayer : Bool -- true if card is dealt to player
    *    revealCard : Bool -- True if the card should be revealed
    */
    private func dealCards(toPlayer : Bool, revealCard: Bool)
    {
      var drawnCard = deckOfCards.popLast()!
      if(toPlayer){
        drawnCard.showCard();
        playerCards.append(drawnCard);
        cardHistory.append("\(DEALER_NAME) deals you a card: [\(drawnCard.description)]")
    
      }
      else
      {
        if(revealCard)
        {
          drawnCard.showCard()
          
          cardHistory.append("\(DEALER_NAME) deals a card to himself: [\(drawnCard.description)]")
        }
        else
        {
          cardHistory.append("\(DEALER_NAME) draws a card to himself and places it face down.")
        }
        dealerCards.append(drawnCard);
      }
      
    }
  
    private func addWagerToBalance(withBlackJack : Bool)
    {
      balance = withBlackJack ? balance + wager + wager/4 : balance + wager 
      wager = 10
    }
  
    private func returnWager()
    {
      wager = wager / 2
      balance = balance + wager
      wager = 10
    }
  
    private func addBalanceToWager()
    {
      balance = balance - wager
    }
  
    
    
    
    /**
    *  handleHit
    *    returns : Void -- deals a card to the player and advances the game by one turn
    **/
    private func handleHit()
    {
      dealCards(toPlayer: true, revealCard: true)
      gameTurn(isPlayersTurn: true, advanceGame: true);
    
    }
    
    /**
    *  handleRules
    *    returns : Void -- Prints rules and returns game to desired state
    *    parameters: exitOnly : Bool -- Whether to use limited controller
    **/
    private func handleRules(exitOnly : Bool = false)
    {
      clearScreen()
      printWithBorders(thingsToPrint : RULES)
      gameTurn(isPlayersTurn: true, advanceGame: false, clear: false, exitOnly : exitOnly)
    }
  
    /**
    *  handleStand
    *    returns : Void -- controls stand game conditions for one turn 
    */
    private func handleStand()  
    {    
      
      dealerCards[1].showCard()
      clearScreen() 
      printWithBorders(thingsToPrint: cardHistory)
      print(renderTable(dealerValue : dealerValueDesc, playerValue : playerValueDesc));
      
      if(dealerCards.count == 2 && dealerValueDesc.value == 21)
      {
        loseGame(withBlackJack : true)
      }
        
        while(dealerValueDesc.value < 17)
        {
            dealCards(toPlayer: false, revealCard: true)
            print("Press Enter to Continue")
            readLine()!
            gameTurn(isPlayersTurn: false, advanceGame: true)
        }  
       gameTurn(isPlayersTurn: false, advanceGame: true);
    }
  
    /**
    *  generateDeck
    *    returns : Card Array -- Array of a shuffled full deck of cards
    **/
    private func generateDeck()
    {
      var deck : [Card] = []
      for r in Rank.orderedRanks
      {
        for s in Suit.orderedSuits
        {
          let newCard : Card = Card(rank : r, suit : s)
          deck.append(newCard)
        }
      }
      deck.shuffle()
      deckOfCards = deck
    }
    
    /*
    *  gameSetup
    *    return : Void -- sets the game up to be played
    *      sets wager and card values
    **/
    public func gameSetup()
    {
      if exitConsole
      {
        printWithBorders(thingsToPrint: ["\(DEALER_NAME): Good Game, kid. See you around."])
        return
      }
      
      addBalanceToWager()
      wager = wager * 2
      generateDeck()
      playerCards = []
      dealerCards = []
      cardHistory = []
      
      generateDeck()
      dealCards(toPlayer: true, revealCard: true);
      dealCards(toPlayer: true, revealCard: true);
      dealCards(toPlayer: false, revealCard: true);
      dealCards(toPlayer: false, revealCard: false);
    
      gameTurn(isPlayersTurn: true, advanceGame: true)
    }
  
  
    /**
    *  gameplayInputController -- Controller Case 5
    *    parameters: 
    *      inputString : String -- string inputted by the user
    *      exitOnly : Bool -- Whether or not to display limited UI options
    **/
    public func gameplayInputController(inputString: String, exitOnly : Bool = false)
    {  
      let caseArr = Array(inputString)
      let command = caseArr.count > 0 ? caseArr[0] : "0"
      var exitGame = false
      switch (command)
      {    
        case "H","h":
          if exitOnly
          {
            printWithBorders(thingsToPrint: ["Invalid input. Attempted command: \(inputString)"])
            inputController(controllerCase: 5, exitOnly: exitOnly)
            break
          }     
          print("You choose to Hit");
          handleHit(); 
        case "S","s":
          if exitOnly
          {
            printWithBorders(thingsToPrint: ["Invalid input. Attempted command: \(inputString)"])
            inputController(controllerCase: 5, exitOnly: exitOnly)
            break
          }
            handleStand()        
        case "Q","q":
          handleRules(exitOnly: exitOnly)
        case "N","n":
          clearScreen()
          printWithBorders(thingsToPrint: exitOnly ? NEW_GAME_MESSAGE : ABANDON_GAME_MESSAGE)
          let userConfirm = readLine()!
          var userConfirmInput = Array(userConfirm)
          if userConfirmInput.count <= 0
          {
            userConfirmInput = ["n"]
          }
          let quitGame = abandonGameConfirmation(inputString: String(userConfirmInput[0]))
          if quitGame {
            exitGame = true
            if !exitOnly
            {
              loseGame(hotExit : true)
              return
            }
            break
          }
          gameTurn(isPlayersTurn: true, advanceGame: false, exitOnly: exitOnly)
        default:
          invalidErrorMessage(controllerCase: 5, inputString: inputString, newInstance: true, exitOnly: exitOnly)
      }
      if exitGame { gameplayLoop(initialSetup : false) }
    }
  
  
    
  
    
    /**
    *  winGame
    *    returns : Void -- handles win game conditions
    *    parameters: withBlackJack : Bool -- whether victory was achieved with a blackjack
    **/
    private func winGame(withBlackJack : Bool = false){
      if(withBlackJack)
      {
        addWagerToBalance(withBlackJack : true)
        printWithBorders(thingsToPrint: ["You win with a BlackJack!!!", "Your new balance is $(\(balance))"])
      }
      else
      {
        addWagerToBalance(withBlackJack : false)
        printWithBorders(thingsToPrint: ["You win!!! Your new balance is $(\(balance))"])
      }
        inputController(controllerCase: 5, exitOnly: true)
    }
    
    /**
    *  tieGame
    *    returns  : Void -- Handles tie game conditions 
    **/
    private func tieGame()
    {
        returnWager()
        printWithBorders(thingsToPrint: ["The game is a tie!", "Your balance is $(\(balance))"])
        inputController(controllerCase: 5, exitOnly: true)
    }
    
    
    /**
    *  loseGame
    *  returns : Void -- Handles lose game conditions
    *  parameters: 
    *    withBlackJack : Bool -- whether the dealer won with a blackjack
    *    hotExit : Bool -- whether the player quit a game in progress
    **/
    private func loseGame(withBlackJack : Bool = false, hotExit : Bool = false)
    {
      wager = 10
      printWithBorders(thingsToPrint: withBlackJack ? ["\(DEALER_NAME) wins with a BlackJack!", "Your new balance is $(\(balance))"] : ["\(DEALER_NAME) wins!", "Your new balance is $(\(balance))"])
      inputController(controllerCase: 5, exitOnly: true)
      if(hotExit){gameplayLoop(initialSetup: false)}
    }
  

  
}

/*************************************************************************
* Global Variables
*/
var game : GameState = GameState()

var exitFlag : Bool = false

/**************************************************************************
* Methods
*/

/************************
* ASCII Rendering Methods
*/

/**
*  printWithBorders
*  returns : Void -- prints a string array with a border
*  parameters: 
*    thingsToPrint : String Array -- An array of items to be printed with a border
**/
func printWithBorders(thingsToPrint : [String])
{

  print(TOP_BAR)
  print(SIDE_BAR + String(repeating: " ", count: TABLE_WIDTH) + SIDE_BAR) 
  for line in thingsToPrint
  {
    let width = line.count
    let rightSpace = line.count % 2 == 0 ? "" : " "
    let space = (TABLE_WIDTH - width) / 2
    print(SIDE_BAR +  String(repeating: " ", count: space)  + line + String(repeating: " ", count: space) + rightSpace + SIDE_BAR)
  }
  print(SIDE_BAR + String(repeating: " ", count: TABLE_WIDTH) + SIDE_BAR)
  print(BOTTOM_BAR)
}


/**
*  clearScreen
*  returns : Void -- Clears console
**/
func clearScreen()
{
  let screenClear = "\u{001B}[2J" 
  print(screenClear)
}

/**
*  clearScreenHard
*  returns : Void -- Fills console and then clears it, so that future 
* text renders at the bottom of the terminal
**/
func clearScreenHard()
{
  print(String(repeating: "\n", count:40))
  clearScreen()
}

/**
*  renderInlineCards
*  returns : String Array of formatted inline cards
*  parameters:
*    cards : Card Array -- Array of cards to be printed
*    cardsPerLine : Int -- Number of cards to be rendered per line
**/
func renderInlineCards(cards : [Card], cardsPerLine: Int) -> [String]
{
  let linesPerCard = 5

  var lineReturn : [String] = []
  
  var printedCards = 0
  while  printedCards < cards.count
  {
    for lineNumber in 0..<linesPerCard
    {
      var lineContent : String = ""
      for currentCard in 0..<cardsPerLine
      {
          lineContent += (cards.count > printedCards + currentCard) ? 
        cards[printedCards + currentCard].displayCard[lineNumber] + " " : ""
      }
      lineReturn.append(lineContent)
    }
    printedCards += cardsPerLine
    } 
  return lineReturn
}

/**
* renderTable
*  returns: String -- Table to be printed
*  Parameters:
*    dealerValue : HandValue -- HandValue struct generated from Dealer Hand
*    playerValue : HandValue -- HandValue struct generated from PLayer Hand
**/
func renderTable(dealerValue: HandValue, playerValue: HandValue) -> String
{
  let cardsPerRow = 8
  let tableRow : String = SIDE_BAR + (String(repeating:" ",count:TABLE_WIDTH)) + SIDE_BAR 
  
  let playerCardWidth : Int = game.playerCards.count * (Card.CARD_FULL_WIDTH)
  let dealerCardWidth : Int = game.dealerCards.count * (Card.CARD_FULL_WIDTH)
  
  let playerSpacing = TABLE_WIDTH - playerCardWidth
  let dealerSpacing = TABLE_WIDTH - dealerCardWidth
   
  let playerSpacingL : String = String(repeating:" ", count: (playerSpacing/2))
  let playerSpacingR : String = String(repeating:" ", count: (playerSpacing - playerSpacingL.count))
  
  let dealerSpacingL : String = String(repeating:" ", count: (dealerSpacing/2))
  let dealerSpacingR : String = String(repeating:" ", count: (dealerSpacing - dealerSpacingL.count))
  
  

  let playerCardsString = SIDE_BAR + playerSpacingL + 
  renderInlineCards(cards: game.playerCards,cardsPerLine: cardsPerRow)
    .joined(separator: "\(playerSpacingR)\(SIDE_BAR)\n\(SIDE_BAR)\(playerSpacingL)") 
  + playerSpacingR + SIDE_BAR
    
  let dealerCardsString = SIDE_BAR + dealerSpacingL + 
  renderInlineCards(cards:  game.dealerCards,cardsPerLine: cardsPerRow)
    .joined(separator: "\(dealerSpacingR)\(SIDE_BAR)\n\(SIDE_BAR)\(dealerSpacingL)") 
  + dealerSpacingR + SIDE_BAR
  
  let dealerBarWidth = dealerValue.descLength
  let playerBarWidth = playerValue.descLength
  
  let dealerBarMargin : String = String(repeating: HORIZONTAL_BAR, count: (TABLE_WIDTH - dealerBarWidth)/2)
  let playerBarMargin : String = String(repeating: HORIZONTAL_BAR, count: (TABLE_WIDTH - playerBarWidth)/2)

  let playerBarRight : String = playerValue.descLength % 2 != 0 ? HORIZONTAL_BAR : ""
  let dealerBarRight : String = dealerValue.descLength % 2 != 0 ? HORIZONTAL_BAR : ""
  
  let dealerBar = TOP_LEFT_BAR + dealerBarMargin + dealerValue.description + 
      dealerBarMargin + dealerBarRight + TOP_RIGHT_BAR
  
  let playerBar = BOTTOM_LEFT_BAR + playerBarMargin + playerValue.description + 
      playerBarMargin + playerBarRight + BOTTOM_RIGHT_BAR  


  let potCenter = "Current Pot: ($\(game.wager))"
  let potWidth = potCenter.count
  let potBar = String(repeating: TABLE_DIVIDER, count: (TABLE_WIDTH - potWidth) / 2)

  let potRight = potWidth % 2 == 0 ? "" : TABLE_DIVIDER

  let potMargin = TABLE_DIVIDER_LEFT + potBar + potCenter + potBar + potRight + TABLE_DIVIDER_RIGHT

  
  return """
  \(dealerBar)
  \(tableRow)
  \(dealerCardsString)
  \(tableRow)
  \(tableRow)
  \(potMargin)
  \(tableRow)
  \(tableRow)
  \(playerCardsString)
  \(tableRow)
  \(playerBar)
  """
   
}

/**
* renderConfirmWager
*  returns: String -- Confirmation message for the player to confirm their BlackJack Wager 
**/
func renderConfirmWager() -> String
{
  return "Confirm ($\(game.wager)) wager? (Y/n) (default is Y)"
}


/**************************
* Controller Methods
*/

/**
* inputController
*  returns : Void -- Used to route controller inputs through various UI elements
*  parameters:
*    controllerCase : Int -- determines where to send the input
*                      1 ) Wager Menu
*                      2 ) Wager Value Input Menu
*                      3 ) Wager Confirmation Menu
*                      4 ) --Deprecated--
*                      5 ) Game Controller Input
*    exitOnly : Int -- Determines whether the player is able to use the 
* normal game controller or a limited version
**/
func inputController(controllerCase: Int, exitOnly : Bool = false) 
{
  var inController : Bool = true;
  var localControllerCase = controllerCase;
  while(inController)
  {
    switch (localControllerCase)
    {
      
      case 1:
        printWithBorders(thingsToPrint: WAGER_MENU); //change wager value menu
        let input : String = readLine()!
      
        clearScreen()
        inController = wagerMenuController(inputString: input);
        printWagerStatus()
        break;
      case 2:
        clearScreen()
        printWithBorders(thingsToPrint: WAGER_INPUT); // input wager menu
        let input : String = readLine() ?? "0"
        inController = wagerValueInput(inputString: input);
        printWagerStatus()
        if inController
        {
           localControllerCase = 1
        }
        break;
      case 3:
        printWagerStatus()
        print(renderConfirmWager()) // confirm wager menu
        let input : String = readLine() ?? "y"
        inController = wagerMenuConfirmation(inputString: input)
        if(inController) {
          localControllerCase = 1
        }
        break;
      case 5: // Game Controller Menu
        printWithBorders(thingsToPrint: exitOnly ? SMALL_CONTROLLER : FULL_CONTROLLER)
        let input : String = readLine()!
        game.gameplayInputController(inputString: input, exitOnly: exitOnly)
        inController = false
      default:
        print("Internal controller error. Attempted controller case = \(controllerCase)")
    }
  }
}





/**
*  wagerMenuController -- Controller Case 1
*    returns : Bool -- Whether to continue the controller loop
*    parameters: inputString : String -- string inputted by user
**/
func wagerMenuController(inputString : String) -> Bool
{
  let input = Array(inputString);
  let command = input.count > 0 ? input[0] : nil
  switch(command)
  {
    case "W","w":
      game.wager = game.wager + 10 <= game.balance ? game.wager + 10 : game.wager
      return true
    case "S","s":
      game.wager = game.wager > 10 ? game.wager - 10 : game.wager
      return true
    case "I","i":
      inputController(controllerCase: 2)
      return false
    case "X", "x":
      printWithBorders(thingsToPrint: ["\(DEALER_NAME): You done for the day?"])
      printWithBorders(thingsToPrint: ["Leave the Game?","[Y] Yes | [N] No"])
      let userConfirm = readLine()!
      var userConfirmInput = Array(userConfirm)
      if userConfirmInput.count <= 0
      {
        userConfirmInput = ["n"]
      }
      if userConfirmInput[0] == "y" || userConfirmInput[0] == "Y"
      {
        game.exitConsole = true
        return false
      }
      else
      {
        clearScreen()
        return true
      }
    case nil: //Confirm menu
      inputController(controllerCase: 3)
      return false
    default: //invalid menu
      invalidErrorMessage(controllerCase: 1, inputString: inputString)
      return true
  }
}


/**
*  wagerValueInput -- Controller Case 2
*    returns : Bool -- Whether to continure the controller loop
*    parameters : inputString : String -- String inputted by user
**/
func wagerValueInput(inputString : String) -> Bool
{
  
  let input = Int(inputString) ?? -1;
  let GREATER_THAN_BALANCE =  ["I'm sorry, player. I can't give you any credit.","Come back when you're a little richer."]
  let NEGATIVE_NUMBER = ["I don't play for chump change.","Keep it above ($10) at least"]
  let NO_CHANGES = ["No changes made to wager."]
  
  switch (input)
  {
  case 10...game.balance:
    game.wager = input
    return false
  case (game.balance+1)...Int.max:
      printWithBorders(thingsToPrint: GREATER_THAN_BALANCE)
    return true
  case Int.min..<10:
    printWithBorders(thingsToPrint: NEGATIVE_NUMBER)
    return true  
  default:
    printWithBorders(thingsToPrint: NO_CHANGES)
    return true
  }
}

/**
*  printWagerStatus 
*    returns : Void -- prints wager and balance
*/
func printWagerStatus()
{
  let printContent = ["Your Balance: ($\(game.balance))",
                      "Wager Amount: ($\(game.wager))"]
  printWithBorders(thingsToPrint: printContent)
}


/**
*  wagerMenuConfirmation -- Controller Case 3
*    returns : Bool -- Whether to continure the controller loop
*    parameters : inputString : String -- String inputted by user
**/
func wagerMenuConfirmation(inputString : String) -> Bool
{
  let input = Array(inputString);
  let command : Character = input.count > 0 ? input[0] : "y";
  switch(command)
  {
    case "Y", "y", nil:
      return false; //this will break to next game state
    default:
      return true;
    
  }
}



/**
*  abandonGameConfirmation -- controllerCase 5.1
*    returns : Bool -- whether or not to abandon the current game
*    parameters : inputString : String -- string inputted by the user
**/
func abandonGameConfirmation(inputString : String) -> Bool
{
  let input = Array(inputString);
  let command : Character = input[0];
  switch(command)
  {
    case "Y", "y": return true
    default: return false
  }
}


/**
*  invalidErrorMessage -- controller helper
*    parameters:
*      controllerCase : Int -- Case of the controller to return to
*      inputString : String -- String inputted by the user
*      newInstance : Bool -- whether to instantiate a new controller instance
*      exitOnly : Bool -- Whether to keep controller 5 in limited mode
*    
**/
func invalidErrorMessage(controllerCase: Int, inputString: String, newInstance : Bool = false, exitOnly: Bool = false)
{
  printWithBorders(thingsToPrint: ["Invalid input.","Attempted Input: \(inputString)"])
  if newInstance {
    inputController(controllerCase: controllerCase, exitOnly: exitOnly) 
  }
}


/*************************************
*  Game Loop Logic
**/


/**
*  gameplayLoop 
*    returns  : Void -- Handles the entire game flow
*    parameters:  initialSetup : Bool -- true if this is the first time cycle of the game 
**/
func gameplayLoop(initialSetup : Bool)
{
  if initialSetup 
  {
    clearScreenHard()
    printWithBorders(thingsToPrint: greeting)
    game = GameState()
  }
  else
  {
    clearScreen()
    if game.balance <= 9
    {
      printWithBorders(thingsToPrint: ["\(DEALER_NAME): Looks like your pocket's run dry"])
      game.exitConsole = true
      game.gameSetup()
      return
    }
    else
    {
      printWithBorders(thingsToPrint: ["How about another game?"])
    }
  }
    printWagerStatus()
    if !game.exitConsole{  
       inputController(controllerCase: 1) 
    }
    clearScreen()
    game.gameSetup()
  
  if game.exitConsole && !exitFlag {
    print("As you stumble out of the pub, a hooded figure approaches you")
    printWithBorders(thingsToPrint: ["Hooded man: I could give you another shot.","Back from the start.","What do you say?"])
    printWithBorders(thingsToPrint: ["Try Again?","[Y] Yes | [N] No"])
    let userConfirm = readLine()!
    var userConfirmInput = Array(userConfirm)
    if userConfirmInput.count <= 0
    {
      userConfirmInput = ["n"]
    }
    if userConfirmInput[0] == "y" || userConfirmInput[0] == "Y"
    {
      gameplayLoop(initialSetup: true)
    }
    else {
      exitFlag = true
      clearScreenHard()
    }
  }
}

/**
* Invoked Methods
**/
gameplayLoop(initialSetup: true)