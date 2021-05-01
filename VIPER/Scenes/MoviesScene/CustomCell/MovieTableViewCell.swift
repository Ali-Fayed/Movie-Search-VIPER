//
//  MovieTableViewCell.swift
//  VIPER
//
//  Created by Ali Fayed on 30/04/2021.
//

import UIKit
import Kingfisher

class MovieTableViewCell: UITableViewCell {

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieYearLabel: UILabel!
    @IBOutlet var movieType: UILabel!
    @IBOutlet var moviePosterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    static let identifier = "cell"

    static func nib() -> UINib {
        return UINib(nibName: "MovieTableViewCell",
                     bundle: nil)
    }

}

extension MovieTableViewCell: MovieCellViewModel {
    func cellData(with model: Movie) {
        movieTitleLabel.text = model.movieTitle
        movieYearLabel.text = model.movieYear
        movieType.text = model.movieType.capitalized
        let posterURL = model.moviePoster
        moviePosterImageView.kf.setImage(with: URL(string: posterURL), placeholder: nil, options: [.transition(.fade(0.7))])
        moviePosterImageView.layer.cornerRadius = 20
        accessoryType = .disclosureIndicator
    }
}
