var Quiz = React.createClass({
  getInitialState(){
    return {
      quiz: this.props.quiz,
      editMode: false,
      errors: {}
    }
  },

  setEditMode(){
    this.setState({editMode: true});
  },

  handleQuestionChange(e){
    var newQuiz = this.state.quiz;
    newQuiz.question = e.target.value;
    this.setState({quiz: newQuiz});
  },

  handleAnswerChange(e){
    var newQuiz = this.state.quiz;
    newQuiz.answer = e.target.value;
    this.setState({quiz: newQuiz});
  },

  handleQuizUpdate(){
    var that = this;
    $.ajax({
      method: 'PUT',
      data: {
        quiz: that.state.quiz,
      },
      url: '/quizes/' + that.state.quiz.id + '.json',
      success: function(res){
        that.setState({
          errors: {},
          quiz: res,
          editMode: false
        });
      },
      error: function(res){
        that.setState({errors: res.responseJSON.errors});
      }
    });
  },

  handleQuizDelete() {
    var that = this;

    $.ajax({
      method: 'DELETE',
      url: '/quizes/' + that.state.quiz.id + '.json',
      success: function(res) {
        that.props.onQuizDelete(that.state.quiz);
      }
    });
  },

  render() {

    if(this.state.editMode){
      markup = (
        <tr>
          <td>
            <input type="text" value={this.state.quiz.question}
                   onChange={this.handleQuestionChange} />
            <span style={{color: 'red'}}>{this.state.errors.question}</span>
          </td>
          <td>
            <input type="text" value={this.state.quiz.answer}
                   onChange={this.handleAnswerChange} />
            <span style={{color: 'red'}}>{this.state.errors.question}</span>
          </td>
          <td>
            <button onClick={this.handleQuizUpdate}>Save Changes</button>
          </td>
        </tr>
      )
    } else {
      markup = (
        <tr>
          <td>{this.state.quiz.question}</td>
          <td>{this.state.quiz.answer}</td>
          <td>
            <button onClick={this.setEditMode}> Edit </button>
            <button onClick={this.handleQuizDelete} style={{color: 'red'}}>Delete</button>
          </td>
        </tr>
      )
    }
    return markup;
  }
});
